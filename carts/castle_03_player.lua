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
end

function player:draw()
  local must_flip=self.direction==joy_left
  spr(1, self.x, self.y,1,1,must_flip)
  spr(self.sword_sprite,self.x+7,self.y)
end

function player:update()
  if self.is_talking then
    self:update_dialog()
    return
  end
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

  self:apply_gravity()

  if self:collides_up() then
    self.y=flr(self.y/8)*8+8
    self.dy=0
  end

  if self:collides_down() then
    self.y=flr(self.y/8)*8
    self.dy=0
  end

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

bat={}

function bat:new(x,y)
  local o={
    start_x=x,
    start_y=y
  }
  setmetatable(o, self)
  self.__index=self
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
end