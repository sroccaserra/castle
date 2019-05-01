-->8
-- hud

known_rooms = {}

function draw_hud()
  spr(65)
  spr(65,120,0,1,1,true)
  spr(65,0,24,1,1,false,true)
  spr(65,120,24,1,1,true,true)

  spr(66,0,8)
  spr(66,0,16)

  spr(66,120,8,1,1,true)
  spr(66,120,16,1,1,true)

  for i=8,112,8 do
    spr(67,i)
  end
  for i=8,112,8 do
    spr(67,i,24,1,1,false,true)
  end

  spr(6,6,4)
  spr(6,14,4)
  spr(6,22,4)
  rectfill(64,5,120,26,7)
  rect(64,5,120,26,4)
  display_known_room_positions()
  game:display_room_position()
  color(11)
  print('~'..game:room_name()..'~',6,20)
end

function display_known_room_positions()
  for _,room in pairs(known_rooms) do
    local map_rect = room.map_rect
    rectfill(map_rect[1],map_rect[2],map_rect[3],map_rect[4], 6)
  end
end

function draw_dialog()
  rectfill(64,5,120,26,1)
  rect(64,5,120,26,12)
  cursor(66,7)
  color(12)
  print('wiz: the door')
  print('is closed!')
end
