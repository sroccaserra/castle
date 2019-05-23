-->8
-- hud

known_rooms = {}
hud_height=32

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

  draw_hearts()

  rectfill(64,5,120,26,7)
  rect(64,5,120,26,4)
  display_known_room_positions()
  game:display_room_position()
  color(11)
  print('~'..game:room_name()..'~',6,20)
end

function draw_hearts()
  for i=0,player.nb_hearts-1 do
    spr(6,6+i*8,4)
  end
  pal(8, 0)
  for i=player.nb_hearts,2 do
    spr(6,6+i*8,4)
  end
  pal()
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
