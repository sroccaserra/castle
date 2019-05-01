-->8
-- game

game={}

function game:pause()
  self.is_paused = true
end

function game:init()
  rooms={
    graveyard={
      name='graveyard',
      camera_x=0,
      camera_y=0,
      east='castle_gate',
      south='underground',
      map_rect={66,16,68,18},
      mobs={bat:new(-18,100)}
    },
    castle_gate={
      name='castle gate',
      camera_x=128,
      camera_y=0,
      west='graveyard',
      map_rect={70,16,72,18},
      mobs={}
    },
    underground={
      name='underground',
      camera_x=0,
      camera_y=96,
      map_rect={66,20,68,22},
      mobs={}
    }
  }

  self:enter_room('castle_gate')
  self.is_paused=false
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

function game:draw_mobs()
  for mob in all(self.room.mobs) do
    mob:draw()
  end
end

function game:update_mobs()
  for mob in all(self.room.mobs) do
    mob:update()
  end
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

function game:swap_tiles(first,second)
  local start_offset = 0x2000+self.room.camera_x/8+self.room.camera_y*0x780/8
  for lin=start_offset,start_offset+0x780,128 do
    for col=0,0xf do
      local offset=lin+col
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
