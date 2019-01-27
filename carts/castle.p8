pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- main

v_0 = 4
acc = -0.33
dx_max=1
camera_x=0
camera_y=0

game={}

function game:pause()
  self.is_paused = true
end

function _init()
  show_graph=false
  show_dot=false
  show_collision_points=false
  play_music=false
  game.is_paused=false
  menuitem(1,"reset",_init)
  menuitem(2,"toggle music",toggle_music)
  menuitem(3,"toggle graph",toggle_graph)
  menuitem(4,"toggle collision_points",toggle_collision_points)
  menuitem(5,"toggle dot",toggle_dot)
  tiles:init()
  player:init()
end

function _draw()
  camera(camera_x,camera_y)
  cls()
  map()
  camera()
  draw_hud()
  player:draw()
  if player.is_talking then
    draw_dialog()
  end
  if show_graph then
    graphic:draw_background()
    graphic:draw_gravity()
  else
    if show_collision_points then
      player:show_collision_points()
    end
    if show_dot then
      dot:draw()
    end
  end
end

function _update60()
  tiles:update()
  if game.is_paused then
    return
  end
  if show_graph then
    update_graph_values()
  elseif show_dot then
    dot:update()
  else
    player:update()
  end
end

-->8
-- player

player = {}

function player:init()
  self.x=32
  self.y=56
  self.dy=0
  self.direction=➡️
  self.is_talking=false
  sword_sprite=2
  min_y=128
end

function player:draw()
  local must_flip=self.direction==⬅️
  spr(1, self.x, self.y,1,1,must_flip)
  spr(self.sword_sprite,self.x+7,self.y)
end

function player:update()
  if self.is_talking then
    self:update_dialog()
    return
  end
  if btnp(🅾️) then
   if is_npc(self:talk_x(),self:talk_y()) then
     self.is_talking=true
     return
   end
   self.sword_sprite=3
  else 
   self.sword_sprite=2
  end
  if btnp(❎) and self:collides_down() then
    self.dy=v_0
  end
  if btn(⬅️) then
   self.x=self.x-dx_max
   self.direction=⬅️
   if self:collides_left() then
     self.x=flr(self.x/8+1)*8-1
   end
  elseif btn(➡️) then
   self.x=self.x+dx_max
   self.direction=➡️
   if self:collides_right() then
     self.x=flr(self.x/8)*8+1
   end
  end

  self:apply_gravity()

  if self:collides_up() then
    self.y=flr(self.y/8)*8+8
    self.dy=0
    return
  end

  if self:collides_down() then
    self.y=flr(self.y/8)*8
    self.dy=0
  end
end

function player:right_x()
  return self.x+6
end

function player:left_x()
  return self.x+1
end

function player:talk_x()
  if self.direction==➡️ then
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
  if btnp(🅾️) then
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

-->8
-- debug

function update_graph_values()
  if btn(⬅️) then
    v_0 = v_0 - .1
  end
  if btn(➡️) then
    v_0 = v_0 + .1
  end
  if btn(⬆️) then
    acc = min(0,acc + .01)
  end
  if btn(⬇️) then
    acc = acc-.01
  end
  if btn(❎) then
    dx_max = dx_max + .01
  end
  if btn(🅾️) then
    dx_max = max(0.1,dx_max-.01)
  end
end

function toggle_graph()
  show_graph = not show_graph
end

function toggle_collision_points()
  show_collision_points = not show_collision_points
end

function toggle_music()
  if play_music then
    music(-1)
    play_music=false
  else
    music()
    play_music=true
  end
end

function pixel(x,y,col)
  line(x,y,x,y,col)
end

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
    camera(camera_x,camera_y)
    local mx=flr(self.x/8)*8
    local my=flr(self.y/8)*8
    rect(mx,my,mx+7,my+7)
  else
    print("ca touche pas",1,1)
  end
  camera()
  print(get_tile(self.x,self.y).." - "..self.x..","..self.y,1,7)
end

function dot:collides()
  return is_solid(self.x,self.y)
end

function dot:update()
    if btn(⬅️) then
    self.x=self.x-1
  end
  if btn(➡️) then
    self.x=self.x+1
  end
  if btn(⬆️) then
    self.y=self.y-1
  end
  if btn(⬇️) then
    self.y=self.y+1
  end
end
-->8
-- tiles

tiles={}

function tiles:init()
  self.swap_counter=0
end

function tiles:update()
  self:swap(25,26)
  self:swap(57,58)
  self.swap_counter=self.swap_counter+1
end

function get_tile(x,y)
  return mget(x/8,y/8)
end

function is_solid(x,y)
  local tile=get_tile(x,y)
  return fget(tile,0)
end

function is_floor(x,y)
  local tile=get_tile(x,y)
  return fget(tile,1)
end

function is_npc(x,y)
  return 7 == get_tile(x,y)
end

function swap_tile(offset,first,second)
  local tile=peek(offset)
  if tile == first then
    poke(offset,second)
  elseif tile == second then
    poke(offset,first)
  end
end

function tiles:swap(first,second)
  local start_offset = 0x2000
  for lin=start_offset,start_offset+0x780,128 do
    for col=0,0xf do
      local offset=lin+col
      if (offset+self.swap_counter)%30==0 then
        swap_tile(offset,first,second)
      end
    end
  end
end

-->8
-- hud

function draw_hud()
  spr(6,6,4)
  spr(6,14,4)
  spr(6,22,4)
  rectfill(64,5,120,26,7)
  rect(64,5,120,26,4)
  rectfill(66,16,69,18,5)
  color(11)
  print("~castle gate~",6,20)
end

function draw_dialog()
  rectfill(64,5,120,26,1)
  rect(64,5,120,26,12)
  cursor(66,7)
  color(12)
  print('"hey,')
  print('what\'s up?"')
  print('🅾️')
end
__gfx__
00000000004bb00070000000ccc0000000000000000a000000000000440000000000000000000000000000000001111100000000000000000000000000000000
0000000000b4bb00700000000c0c0000008ee70000a8a0000000000044888000000000000000000000000000011bb2bb00000000000000000000000000000000
0070070000bbbbb070000000c0c0c000088ee77000a8a000077077004066680000000000000000000000000001b2222200000000000000000000000000000000
00077000004f4f00700000000c0c0c0004488ee0000a00007887887040f8f6000000000000000000000000001b20000000000000000000000000000000000000
00077000004fff004000000000c0cc0004488ee0000a00007888887040fff6000000000000000000000000001b20000000000000000000000000000000000000
00700700fbbbbbbf400000004477770002244880000aa00007888700f86668800000000000000000000000001b20000000000000000000000000000000000000
0000000000bbbb00000000000000000000244800000a000000787000406688f00000000000000000000000001b20000000000000000000000000000000000000
0000000000400400000000000000000000000000000aa00000070000406688000000000000000000000000001b20000000000000000000000000000000000000
55555555555555555000000055555555555005555554055555540000000005550000000000008000000800000000000000000000000000000000000000000000
77777775777777757700000007777775770000757744447577444400000000750000000000089000000880000000000000000000000000000000000000000000
7777777577777775777000000077777570000005740404057404040000000005000000000008a0000009a0000000000000000000000000000000000000000000
77777775777777757777000000077775700000057445454570000000000000050000000000008400000084000000000000000000000000000000000000000000
00000000555555555555500000005555500000055404040550000000000000050000000000000400000004000000000000000000000000000000000000000000
00000000777577777775770000000777700000077445454770000000000000070000000000000040000000400000000000000000000000000000000000000000
00000000777577777775777000000077700000077404040770000000000000070000000000000045000000450000000000000000000000000000000000000000
00000000777577777775777700000007700000077445454770000000000000070000000000000005000000050000000000000000000000000000000000000000
00000000000000005555555500000005000000005404040550000000000000005404040555555555000000000000000000000000000000000000000000000000
00000000000000007777777000000075000000007445454570000000000000007000000577777775000000000000000000000000000000000000000000000000
00000000000000007777770000000775000000007404040570000000000000007000000577777775000000000000000000000000000000000000000000000000
00000000000000007777700000007775000000007445454570000000000000007000000577777775000000000000000000000000000000000000000000000000
55555555000000005555000000055555000000005404040550000000000000005000000555555555000000000000000000000000000000000000000000000000
77757777000000007770000000757777000000007445454770000000000000007000000777757777000000000000000000000000000000000000000000000000
77757777000000007700000007757777000000007404040770000000000000007000000777757777000000000000000000000000000000000000000000000000
77757777000000007000000077757777000000007444444770000000000000007000000777757777000000000000000000000000000000000000000000000000
5555555500000000000500005555000099999999000000099000000099000099000000000000000000000000977777744ff99994000000000000000000000000
44444445000000005050000077770000888888890000008988000000800000090000000000000000000000004999999244444444000000000000000000000000
44444445000000050500000077770000999999990000099999900000000000000000000001100011110110004914429242422422000000000000000000000000
4444444500000050005000007777000088898888000088888889000000000000000000001c7111c7c71c711149499f9220202020000000000000000000000000
000000000000050005000000555555559999999900099999999990000000000000099000cccccccccccccccc49499f9200002002000000000000000000000000
000000000000005050000000777577778888888900888889888888000000000000888800cccccccccccccccc492ff79200020002000000000000000000000000
000000000000050500000000777577779999999909999999999999900000000009999990cccccccccccccccc4999999200020000000000000000000000000000
000000000000500000000000777577778889888888898888888988880000000088898888cccccccccccccccc1222222100002000000000000000000000000000
00060000000011111111110011111111000000000055550000555500005555000555555005000000055555000055550000000000000000000000000000000000
0055600001013bbbbbb31110bbbbbbbb000000000577770005777750057777505777777557500000577777500057750000000000000000000000000000000000
05555600111b11111111b10011111111000000005755550057555575575555000557755057500000575555000057750000000000000000000000000000000000
0567777011b1100000011b1000000000000000005750000057500575057777500057750057500000577750000057750000000000000000000000000000000000
05060607131100000000113100000000000000005750000057500575005555750057750057500000575500000057750000000000000000000000000000000000
056666601b100000000001b100000000111111115755550057777775055555750057750057555500575555000055550000000000000000000000000000000000
055555001b100000000001b100000000bbbbbbbb0577775057555575577777500057750057777750577777500057750000000000000000000000000000000000
055556001b100000000001b100000000111111110055555057500575055555000057750005555500055555000005500000000000000000000000000000000000
566ddddd1b100000000001b11b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
555d567d1b100000000001b11b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d567d1b100000000001b11b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
555d567d13110000000011311b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5555d6d001b1100000011b111b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56056d00001b11111111b1111b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5605600001113bbbbbb310101b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5565556000111111111100001b100000000001b10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b10b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b1000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01b10b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001bb100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100
01013bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb31110
111b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111b100
11b11000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011b10
13110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001131
1b1000000000000000000000000000000000000000000000000000000000000044444444444444444444444444444444444444444444444444444444400001b1
1b1000077077000770770007707700000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000788788707887887078878870000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000788888707888887078888870000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000078887000788870007888700000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000007870000078700000787000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000700000007000000070000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047555577777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047555577777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047555577777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b100000000bb0bbb00bb0bbb0b000bbb000000bb0bbb0bbb0bbb0000000000047777777777777777777777777777777777777777777777777777777400001b1
1b100000b0b000b0b0b0000b00b000b0000000b000b0b00b00b00000b000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000bbb0b000bbb0bbb00b00b000bb000000b000bbb00b00bb00bbb000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000b000b000b0b000b00b00b000b0000000b0b0b0b00b00b000b00000000047777777777777777777777777777777777777777777777777777777400001b1
1b100000000bb0b0b0bb000b00bbb0bbb00000bbb0b0b00b00bbb0000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000047777777777777777777777777777777777777777777777777777777400001b1
1b1000000000000000000000000000000000000000000000000000000000000044444444444444444444444444444444444444444444444444444444400001b1
13110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001131
01b11000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011b11
001b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111b111
01113bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb31010
00111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009900000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088880000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000999999000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000008889888800000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000099999999990000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000898888888988000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000009999999999999900000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000088888889888888890000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000999999999999999999000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000008888898888888988888800000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000099999999999999999999990000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000888988888889888888898888000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000009999999999999999999999999900000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000089888888898888888988888889880000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000999999999999999999999999999999000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000008888888988888889888888898888888900000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000099999999999999999999999999999999990000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000888889888888898888888988888889888888000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000009999999999999999999999999999999999999900000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000088898888888988888889888888898888888988880000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000999999999999999999900009999999999999999999000000000000000
00000000000000000000000000000000000000000000000000000000000000000000008988888889888888898000000988888889888888898800000000000000
00000000000000000000000000000000000000000000000000000000000000000000099999999999999999990000000099999999999999999990000000000000
00000000000000000000000000000000000000000000000000000000000000000000888888898888888988880000000088898888888988888889000000000000
00000000000000000000000000000000000000000000000000000000000000000009999999999999999999990000000099999999999999999999900000000000
00000000000000000000000000000000000000000000000000000000000000000088888988888889888888890000000088888889888888898888880000000000
00000000000000000000000000000000000000000000000000000000000000000999999999999999999999990000000099999999999999999999999000000000
00000000000000000000000000000000000000000000000000000000000000008889888888898888888988880000000088898888888988888889888800000000
00000000000000005555555500000000004bb0070000000000000000000000099999999999999999999999999999999999999999999999999999999990000000
0000000000000000777777750000000000b4bb070000000000000000000000898888888988888889888888898888888988888889888888898888888988000000
0000000000000000777777750000000000bbbbb70000000000000000000009999999999999999999999999999999999999999999999999999999999999900000
00000000000000007777777500000000004f4f070000000000000000000088888889888888898888888988888889888888898888888988888889888888890000
00000000000000005555555500000000004fff040000000000000000000999999999999999999999999999999999999999999999999999999999999999999000
00000000000000007775777700000000fbbbbbb40000000000000000008888898888888988888889888888898888888988888889888888898888888988888800
0000000000000000777577770000000000bbbb000000000000000000099999999999999999999999999999999999999999999999999999999999999999999990
00000000000000007775777700000000004004000000000000000000888988888889888888898888888988888889888888898888888988888889888888898888
00000000000000000000000000000000555555550000000000000000555555550000000055555555000000005555555500000000555555550000000055555555
00000000000000000000000000000000777777750000000000000000777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000777777750000000000000005777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000777777750000000000000050777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000555555550000000000000500555555550000000055555555000000005555555500000000555555550000000055555555
00000000000000000000000000000000777577770000000000000050777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000777577770000000000000505777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000777577770000000000005000777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000000000000000000000050000555555555555555555555555555555555555555555555555555555555555555555555555
00000000000000000000000000000000000000000000000050500000077777757777777577777775777777757777777577777775777777757777777577777770
00000000000000000000000000000000000000000000000505000000007777757777777577777775777777757777777577777775777777757777777577777700
00000000000000000000000000000000000000000000005000500000000777757777777577777775777777757777777577777775777777757777777577777000
00000000000000000000000000000000000000000000050005000000000055555555555555555555555555555555555555555555555555555555555555550000
00000000000000000000000000000000000000000000005050000000000007777775777777757777777577777775777777757777777577777775777777700000
00000000000000000000000000000000000000000000050500000000000000777775777777757777777577777775777777757777777577777775777777000000
00000000000000000000000000000000000000000000500000000000000000077775777777757777777577777775777777757777777577777775777770000000
000000004ff999944ff999944ff99994000000000005000000000000000080005555555555555555555555550000000000000000000000005555555500000000
00000000444444444444444444444444000000005050000000000000000890007777777577777775777777700000000000000000000000007777777500000000
000000004242242242422422424224220000000505000000000000000008a0007777777577777775777777000000000000000000000000007777777500000000
00000000202020202020202020202020000000500050000000000000000084007777777577777775777770000000000000000000000000007777777500000000
00000000000020020000200200002002000005000500000000000000000004005555555555555555555500000000000000000000000000005555555500000000
00000000000200020002000200020002000000505000000000000000000000407775777777757777777000000000000000000000000000007775777700000000
00000000000200000002000000020000000005050000000000000000000000457775777777757777770000000000000000000000000000007775777700000000
00000000000020000000200000002000000050000000000000000000000000057775777777757777700000000000000000000000000000007775777700000000
00000000000000000000000000000000000500000000000000000000000000005554055555555555000000000006000000000000000800005555555500000000
00000000000000000000000000000000505000000000000000000000000000007744447577777770000000000055600000000000000880007777777500000000
000000000000000000000000000000050500000000000000000000000000000074040405777777000000000005555600000000000009a0007777777500000000
00000000000000000000000000000050005000000000000000000000000000007445454577777000000000000567777000000000000084007777777500000000
00000000000000000000000000000500050000000000000000000000000000005404040555550000000000000506060700000000000004005555555500000000
00000000000000000000000000000050500000000000000000000000000000007445454777700000000000000566666000000000000000407775777700000000
00000000000000000000000000000505000000000000000000000000000000007404040777000000000000000555550000000000000000457775777700000000
00000000000000000000000000005000000000000000000000000000000000007445454770000000000000000555560000000000000000057775777700000000
0000000000000000000000000005000000000000977777740000000044000000540404050000000000000000566ddddd00000000000a00005554055500000000
0000000000000000000000005050000000000000499999920000000044888000744545450000000000000000555d567d0000000000a8a0007744447500000000
0000000000000000000000050500000000000000491442920000000040666800740404050000000000000000666d567d0000000000a8a0007404040500000000
000000000000000000000050005000000000000049499f920000000040f8f600744545450000000000000000555d567d00000000000a00007445454500000000
000000000000000000000500050000000000000049499f920000000040fff6005404040500000000000000005555d6d000000000000a00005404040500000000
0000000000000000000000505000000000000000492ff79200000000f866688074454547000000000000000056056d0000000000000aa0007445454700000000
00000000000000000000050500000000000000004999999200000000406688f07404040700000000000000005605600000000000000a00007404040700000000
00000000000000000000500000000000000000001222222100000000406688007444444700000000000000005565556000000000000aa0007445454700000000
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555550000000000005404040500000000
77777770444444454444444544444445444444454444444507777775777777757777777577777775777777757777777577770000008ee7007445454500000000
77777700444444454444444544444445444444454444444500777775777777757777777577777775777777757777777577770000088ee7707404040500000000
7777700044444445444444454444444544444445444444450007777577777775777777757777777577777775777777757777000004488ee07445454500000000
5555000000000000000000000000000000000000000000000000555555555555555555555555555555555555555555555555555504488ee05404040500000000
77700000000000000000000000000000000000000000000000000777777577777775777777757777777577777775777777757777022448807445454700000000
77000000000000000000000000000000000000000000000000000077777577777775777777757777777577777775777777757777002448007404040700000000
70000000000000000000000000000000000000000000000000000007777577777775777777757777777577777775777777757777000000007444444700000000
00000000000000000000000000000000000000000000000000000000555555555555555555555555555555555555555555555555555555555555555555555555
00000000000000000000000000000000000000000000000000000000777777757777777577777775777777757777777577777775777777757777777577777775
01100011011000110110001101100011011000110110001101100011777777757777777577777775777777757777777577777775777777757777777577777775
1c7111c71c7111c71c7111c71c7111c71c7111c71c7111c71c7111c7777777757777777577777775777777757777777577777775777777757777777577777775
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc555555555555555555555555555555555555555555555555555555555555555555555555
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777

__gff__
0001000000000000000000000000000001010002000100000000000000000000010002000001000000000000000000000100000100000000000000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4143434343434343434343434343434200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5300000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5300000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5144444444444444444444444444445200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000035343600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000003534343436000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000353434373434360000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000110000000035343434343434343600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011003111001100110011001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000313213111111111111112200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003c3c3c31320019292922000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000003132000000152200400019110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00003132003b0007250000500005150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2230303030301311111111113304250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3939393939393911111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0110010015550000000000018550000000000000000000001a55000500005001c5500050000500005001d5501c55000500005001a550005000050000500005001755000500005001355000500005000050015550
011000001755000500005001855000500005000050000500155500050000500155500050000500005001455015550005000050017550005000050000500005001455000500005001055000500005000050000500
0110000000000000000000009050000000000000000000000000000000000000c0500000000000000000000000000000000000007050000000000000000000000000000000000000705000000000000000000000
011000000000000000000000905000000000000000000000000000000000000090500000000000000000000000000000000000004050000000000000000000000000000000000000405000000000000000000000
__music__
00 01034344
02 02044344

