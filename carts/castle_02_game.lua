-->8
-- game

game={}
sparks={}

room_width = 128
room_height = 96

function game:pause()
  self.is_paused = true
end

function game:init()
  rooms = {
    graveyard = {
      name = 'graveyard',
      camera_x = 0,
      camera_y = 0,
      east = 'castle_gate',
      south = 'underground',
      map_rect = {66, 16, 68, 18},
      mobs = {bat:new(-18, 100)}
    },
    castle_gate = {
      name = 'castle gate',
      camera_x = room_width,
      camera_y = 0,
      west = 'graveyard',
      map_rect = {70, 16, 72, 18},
      mobs = {},
      draw_sky = true
    },
    underground = {
      name = 'underground',
      camera_x = 0,
      camera_y = room_height,
      east = 'secret_pathway',
      map_rect = {66, 20, 68, 22},
      mobs = {key:new(16, 63)}
    },
    secret_pathway = {
      name = 'secret',
      camera_x = room_width,
      camera_y = room_height,
      west = 'underground',
      east = 'stairway',
      map_rect = {70, 20, 72, 22},
      mobs = {}
    },
    stairway = {
      name = 'stairway',
      camera_x = room_width * 2,
      camera_y = room_height,
      west = 'secret_pathway',
      map_rect = {74, 20, 76, 22},
      mobs = {}
    }
  }

  self:enter_room('castle_gate')
  self.is_paused=false
end

function game:draw()
  camera()
  cls()
  draw_hud()
  self:draw_room()
  player:draw()
  self:draw_mobs()
  if player.is_talking then
    draw_dialog()
  end
  if show_graph then
    graphic:draw_plot_background()
    graphic:draw_gravity_plot()
  else
    if show_collision_points then
      player:show_collision_points()
      player:draw_collision_boxes()
    end
    if show_dot then
      dot:draw()
    end
  end
end

function game:update()
  if player:is_dead() then
    goto_death_screen()
    return
  end

  tiles:update()
  if self.is_paused then
    return
  end
  if show_graph then
    update_graph_values()
  elseif show_dot then
    dot:update()
  else
    self:update_mobs()
    player:update()
  end
end

function game:room_camera()
  return self.room.camera_x,self.room.camera_y
end

function game:room_name()
  return self.room.name
end

function game:enter_room(room_key)
  local next_room=rooms[room_key]
  if not next_room then
    return
  end
  self.room = next_room
  known_rooms[room_key]=next_room
  for mob in all(next_room.mobs) do
    mob:init()
  end
end

function game:draw_sky()
  for i=0,120,8 do
    spr(43,i,48,1,1,i%16 == 0)
  end
  for j=0,8,8 do
    for i=0,120,8 do
      spr(45,i,32+j)
    end
  end
  spr(44,8,40)
end

function game:draw_room()
  if self.room.draw_sky then
    self:draw_sky()
  end
  local camera_x,camera_y=self:room_camera()
  map(camera_x/8,camera_y/8,0,hud_height,16,12)
end

function game:draw_mobs()
  for mob in all(self.room.mobs) do
    mob:draw()
  end
  for spark in all(sparks) do
    spark:draw()
  end
end

function game:update_mobs()
  for mob in all(self.room.mobs) do
    mob:update()
  end
  for spark in all(sparks) do
    spark:update()
  end
end

function game:remove_mob(mob)
  del(self.room.mobs, mob)
end

function game:go_west()
  self:enter_room(self.room.west)
end

function game:go_east()
  self:enter_room(self.room.east)
end

function game:go_south()
  self:enter_room(self.room.south)
end

function game:get_tile(x,y)
  return mget((self.room.camera_x+x)/8,(self.room.camera_y+y-hud_height)/8)
end

--
-- 0, 16, ... , 127
-- 128, ... , 255
-- ...
--

function game:swap_tiles(first,second)
  local start_offset = 0x2000+(self.room.camera_y/8)*0x80+self.room.camera_x/8
  for row=start_offset,start_offset+0x580,128 do
    for col=0,15 do
      local offset=row+col
      if (offset+tiles.swap_counter)%30==0 then
        swap_tile(offset,first,second)
      end
    end
  end
end

function game:display_room_position()
  local map_rect = self.room.map_rect
  rectfill(map_rect[1],map_rect[2],map_rect[3],map_rect[4], 5)
end
