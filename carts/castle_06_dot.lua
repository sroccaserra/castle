-->8
-- dot

dot = {
  x=63,
  y=63
}

function toggle_dot()
  show_dot = not show_dot
end

function dot:draw()
  color(11)
  line(self.x,self.y-1,self.x,self.y-1)
  line(self.x,self.y+1,self.x,self.y+1)
  line(self.x-1,self.y,self.x-1,self.y)
  line(self.x+1,self.y,self.x+1,self.y)
  camera()
  cursor()
  rectfill(0,0,63,12,5)
  color(11)
  if self:collides() then
    print("ca touche",1,1)
    local mx=flr(self.x/8)*8
    local my=flr(self.y/8)*8
    rect(mx,my,mx+7,my+7)
  else
    print("ca touche pas",1,1)
  end
  camera()
  print(game:get_tile(self.x,self.y).." - "..self.x..","..self.y,1,7)
end

function dot:collides()
  return is_solid(self.x,self.y)
end

function dot:update()
    if btn(joy_left) then
    self.x=self.x-1
  end
  if btn(joy_right) then
    self.x=self.x+1
  end
  if btn(joy_up) then
    self.y=self.y-1
  end
  if btn(joy_down) then
    self.y=self.y+1
  end
end
