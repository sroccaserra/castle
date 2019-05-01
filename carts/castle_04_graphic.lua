-->8
-- graphic

graphic = {
  top=0,
  bottom=127,
  right=127,
  left=0
}

function graphic:draw_background()
  camera()
  cursor()
  color(6)
  rectfill(0, self.top, self.right, self.bottom)

  color(11)
  for i=self.bottom,self.top,-8 do
    line(self.left,i, self.right,i)
  end
  for i=self.left,self.right,8 do
    line(i,self.bottom,i,self.top)
  end

  color(5)
  print('acc: '..acc)
  print('v_0: '..v_0)
  print('dx_max: '..dx_max)
end

function graphic:plot(x1,y1,x2,y2,c)
  line(x1,self.bottom-y1,
       x2,self.bottom-y2,c or 1)
end

function graphic:draw_gravity()
  camera()
  local y2 = 0
  local x2 = 0
  local dy = v_0

  for t=1,self.right+dx_max,dx_max do
   local x1 = x2
   local y1 = y2
   x2 = t
   y2 = y2+dy
   dy = dy+acc
   self:plot(x1,y1,x2,y2)
   self:plot(x2,y2,x2,0)
   if y2 < 0 then
     break
   end
  end
end
