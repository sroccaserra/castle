-->8
-- player

player = {}

function player:init()
  self.x=32
  self.y=104
  self.dy=0
  self.direction=joy_right
  self.is_talking=false
  sword_sprite=2
  min_y=128
  self.recover_frames = 0
  self.nb_hearts = 3
end

function player:draw()
  if self:is_recovering() and 0 == flr(12*t())%2 then
    return
  end
  local must_flip=self.direction==joy_left
  spr(1, self.x, self.y,1,1,must_flip)
  local sword_x = must_flip and self.x-7 or self.x+7
  spr(self.sword_sprite,sword_x,self.y,1,1,must_flip)
end

function player:update()
  if self.is_talking then
    self:update_dialog()
    return
  end

  if self:is_recovering() then
    self.recover_frames = self.recover_frames - 1
  end

  self:apply_joystick_commands()
  self:apply_gravity()
  self:apply_collisions()

  self:change_room_if_out_of_bound()
end

function player:apply_joystick_commands()
  if btnp(joy_o) then
   if is_npc(self:talk_x(),self:talk_y()) then
     self.is_talking=true
     return
   end
   self.sword_sprite=3
  else
   self.sword_sprite=2
  end
  if btnp(joy_x) and self:collides_down() then
    self.dy=v_0
  end
  if btn(joy_left) then
   self.x=self.x-dx_max
   self.direction=joy_left
   if self:collides_left() then
     self.x=flr(self.x/8+1)*8-1
   end
  elseif btn(joy_right) then
   self.x=self.x+dx_max
   self.direction=joy_right
   if self:collides_right() then
     self.x=flr(self.x/8)*8+1
   end
  end
end

function player:apply_collisions()
  if self:collides_up() then
    self.y=flr(self.y/8)*8+8
    self.dy=0
  end

  if self:collides_down() then
    self.y=flr(self.y/8)*8
    self.dy=0
  end
end

function player:change_room_if_out_of_bound()
  if self.x<0 then
    game:go_west()
    self.x=120
  elseif self.x>120 then
    game:go_east()
    self.x=0
  end
  if self.y>120 then
    game:go_south()
    self.y=32
  end
end

function player:right_x()
  return self.x+6
end

function player:left_x()
  return self.x+1
end

function player:talk_x()
  if self.direction==joy_right then
    return self.x+12
  else
    return self.x-4
  end
end

function player:talk_y()
  return self.y+4
end

function player:collides_right()
  return is_solid(self:right_x(),self.y)
end

function player:collides_left()
  return is_solid(self:left_x(),self.y)
end

function player:collides_up()
  if self.dy<0 then
    return false
  end
  local over_y=self.y
  return is_solid(self:right_x(),over_y)
      or is_solid(self:left_x(),over_y)
end

function player:collides_down()
  if self.dy>0 then
    return false
  end
  local under_y=self.y+8
  return is_solid(self:right_x(),under_y)
      or is_solid(self:left_x(),under_y)
      or is_floor(self:right_x(),under_y)
      or is_floor(self:left_x(),under_y)
end

function player:apply_gravity()
  self.y = self.y-self.dy
  self.dy = max(-7,self.dy + acc)
end

function player:start_talking()
  self.is_talking=true
end

function player:update_dialog()
  if btnp(joy_o) then
   self.is_talking=false
  end  
end

function player:show_collision_points()
  min_y=min(min_y,self.y)

  cursor()
  rectfill(0,0,63,18)

  print('y: '..self.y,1,1,8)
  print('dy: '..self.dy,1,7,8)
  print('min y: '..min_y,1,13,8)

  pixel(self:left_x(),self.y,8)
  pixel(self:right_x(),self.y,8)
  pixel(self:right_x(),self.y+8,8)
  pixel(self:left_x(),self.y+8,8)
  pixel(self:talk_x(),self:talk_y(),8)
end

function player:collision_box()
  local padding = 2
   return {
    x_left = self.x+padding,
    y_top = self.y+padding,
    x_right = self.x+8-padding,
    y_bottom = self.y+8-padding,
  }
end

function player:draw_collision_box()
  local box = self:collision_box()
  rect(box.x_left, box.y_top, box.x_right, box.y_bottom)
end

function player:hit()
  if self:is_recovering() then
    return
  end
  self.recover_frames = 60
  self.nb_hearts = self.nb_hearts - 1
end

function player:is_recovering()
  return self.recover_frames > 0
end

---
-- bat

bat={}
bat.__index=bat

function bat:new(x,y)
  local o={
    start_x=x,
    start_y=y
  }
  setmetatable(o, self)
  o:init()
  return o
end

function bat:init()
  self.x=self.start_x
  self.y=self.start_y
  self.animation={8,9}
  self.frame=1
  self.time=0
end

function bat:draw()
  local sprite=self.animation[self.frame]
  spr(sprite,self.x,self.y)
end

function bat:collision_box()
  local padding = 2
  return {
    x_left = self.x+padding,
    y_top = self.y+padding,
    x_right = self.x+8-padding,
    y_bottom = self.y+8-padding,
  }
end

function bat:collides_with(a_bounded_object)
  local collision_box = self:collision_box()
  local other_collision_box = a_bounded_object:collision_box()

  max_left = max(collision_box.x_left, other_collision_box.x_left)
  min_right = min(collision_box.x_right, other_collision_box.x_right)
  max_top = max(collision_box.y_top, other_collision_box.y_top)
  min_bottom = min(collision_box.y_bottom, other_collision_box.y_bottom)

  return max_left <= min_right and max_top <= min_bottom
end

function bat:update()
  self.x=self.x+.5
  self.time=self.time+1
  self.y=self.start_y+2*sin(t()/2)
  if self.time%6==0 then
    self.frame=3-self.frame
  end
  if self.x>128 then
    self.x=self.start_x
  end

  if self:collides_with(player) then
    player:hit()
  end
end
