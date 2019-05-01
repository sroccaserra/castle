pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- ~castle~
-- by sroccaserra

#include castle_01_main.lua
#include castle_02_game.lua
#include castle_03_player.lua
#include castle_04_graphic.lua
#include castle_05_debug.lua
#include castle_06_dot.lua
#include castle_07_tiles.lua
#include castle_08_hud.lua
__gfx__
00000000004bb00070000000ccc0000000000000000a00000000000044000000d000000000000000200000000001111142244444333333330000000000000000
0000000000b4bb00700000000c0c0000008ee70000a8a00000000000448880002d00d0d00000d0d012002020011bb2bb24444224344433430006000000000000
0070070000bbbbb070000000c0c0c000088ee77000a8a000077077004066680022d0dddd0000dddd1120222201b2222242442444023424440600600000000000
00077000004f4f00700000000c0c0c0004488ee0000a00007887887040f8f600222ddadadddddada12122a2a1b20000024244442242443420600666600000000
00077000004fff004000000000c0cc0004488ee0000a00007888887040fff600d222dddddddddddd211122221b20000022442424220424406666660000000000
00700700fbbbbbbf400000004477770002244880000aa00007888700f86668800ddddd000ddddd00022222001b20000024442244000422000660060000000000
0000000000bbbb00000000000000000000244800000a000000787000406688f000ddd00000ddd000002220001b20000042244424400400000066066000000000
0000000000400400000000000000000000000000000aa000000700004066880000000000000d0000000000001b20000044242244004004040066006000000000
55555555555555555000000055555555555005555554055555540000000005550000000000008000000800000000000000000000000666000000006666000000
77777775777777757700000007777775770000757744447577444400000000750000000000089000000880000000000000000000006666600000a77777660000
7777777577777775777000000077777570000005740404057404040000000005000000000008a0000009a0000000000000000000006666600006777767777000
77777775777777757777000000077775700000057445454570000000000000050000000000008400000084000000000000000000066555660067777677777700
00000000555555555555500000005555500000055404040550000000000000050000000000000400000004000000000000000000066666660667767666767770
00000000777577777775770000000777700000077445454770000000000000070000000000000040000000400000000000000000066555660667777766667770
0000000077757777777577700000007770000007740404077000000000000007000000000000004500000045000000000000000006666666a677677776677677
0000000077757777777577770000000770000007744545477000000000000007000000000000000500000005000000000000000006666666a776677777776777
0000000000000000555555550000000500000000540404055000000000000000540404055555555500000000000000000000000000000000a777767777677777
0000000000000000777777700000007500000000744545457000000000000000700000057777777500000000000000000000000000000000a777766777777767
00000000000000007777770000000775000000007404040570000000000000007000000577777775000000000000000000000000000000000a77777776667770
00000000000000007777700000007775000000007445454570000000000000007000000577777775000000000000000000000000000000000a777777666777a0
555555550000000055550000000555550000000054040405500000000000000050000005555555550000000000000000000000000000000000a7767766777a00
7775777700000000777000000075777700000000744545477000000000000000700000077775777700000000000000000000000000000000000a77677676a000
77757777000000007700000007757777000000007404040770000000000000007000000777757777000000000000000000000000000000000000aa7776aa0000
7775777700000000700000007775777700000000744444477000000000000000700000077775777700000000000000000000000000000000000000aaaa000000
5555555500000000000500005555000099999999000000099000000099000099000000000000000000000000977777744ff99994000000000000000000000000
44444445000000005050000077770000888888890000008988000000800000090000000000000000000000004999999244444444000000000000000000000000
44444445000000050500000077770000999999990000099999900000000000000000000001100011110110004914429242422422000000000000000000000000
4444444500000050005000007777000088898888000088888889000000000000000000001c7111c7c71c711149499f9220202020000000000000000000000000
000000000000050005000000555555559999999900099999999990000000000000099000cccccccccccccccc49499f9200002002000000000000000000000000
000000000000005050000000777577778888888900888889888888000000000000888800cccccccccccccccc492ff79200020002000000000000000000000000
000000000000050500000000777577779999999909999999999999900000000009999990cccccccccccccccc4999999200020000000000000000000000000000
000000000000500000000000777577778889888888898888888988880000000088898888cccccccccccccccc1222222100002000000000000000000000000000
00060000000011111111110011111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0055600001013bbbbbb31110bbbbbbbb000000000000040044444400000000000000000000000999990000000000000000000000000000000000000000000000
05555600111b11111111b10011111111000000000004044400000440000000000000000000009ccccc9000000000000000000000000000000000000000000000
0567777011b1100000011b100000000000000000004444000000000440000444400000000009ccc77cc900000000000000000000000000000000000000000000
0506060713110000000011310000000000000000004040000400004444444444440000000009ccccc7c900000000000000000000000000000000000000000000
056666601b100000000001b10000000011111111004000000404444443000000440000000009ccccccc900000000000000000000000000000000000000000000
055555001b100000000001b100000000bbbbbbbb004000000000444403400000044000000009ccccccc900000000000000000000000000000000000000000000
055556001b100000000001b10000000011111111404400000004444043000000340400000009ccccccc900000000000000000000000000000000000000000000
566ddddd1b100000000001b11b100000000001b1004400000004444443000000344040000009ccccccc900000000000000000044444455000000000005000000
555d567d1b100000000001b11b100000000001b100400000004404440300000030d004000009ccccccc900000000000000064444444444500000000004500000
666d567d1b100000000001b11b100000000001b100400000044440000300000030d004000009ccccccc900000000000000004444444444450000000004500000
555d567d13110000000011311b100000000001b100000000044400000300000030d000400009ccccccc900000000000000004444444444450000000004500000
5555d6d001b1100000011b111b100000000001b1330000004440000003000000d0d000400009ccccccc900000000000000004444444444450000000004500000
56056d00001b11111111b1111b100000000001b13300000444000000030000023040004000099ccccc9900000000000000006644444444450000000004500000
5605600001113bbbbbb310101b100000000001b1300000044d000000030000003000004000090999990900000000000000002266666666450000000004500000
5565556000111111111100001b100000000001b1300000044d000000030000023000004000090000000900000000000000002222222299650000000004500000
000000aa7700000000000000000000000000000030000444d0000000030000003000004000000000000000000000000000002222222922950000000004500000
0000aaa7777700000000000000000000000000000000044440000000030000003000004000000000000000000000000000006622222922950000000004500000
000aaaa7777770000000000000000000000000000000044440000000440000003200004000000000000000000000000000004466666699250000000004500000
00aaaa77777777000000000000000000000000000000044400000000030000002000004000000000000000000000000000004444444444650000000004500000
0aaaaa7777aa77700000000000000000000000000000044d00000000000000023000004000000000000000000000000000064444444444450000000004500000
0aaaa7777a77a7700000000000000000000000000000044d00000000000000003000000000000000000000000000000000004444444444450000000004500000
aaaaa7777777a7770000000000000000000000000000044d00000000000000000000000000000000000000000000000000004444444444450000000004500000
aaaaa77777aa77770000000000000000000000000000044d00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaa777777777770000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaa777777777770000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaa777777777700000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
0aaaa777777777700000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
00aaaa77777777000000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
000aaa77777770000000000000000000000000000000444d00000000000000000000000000000000000000000000000000000000000000000000000000000000
0000aaa7777700000000000000000000000000000004444440000000000000000000000000000000000000000000000000000000000000000000000000000000
000000aa7700000000000000000000000000000000444444d4000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000099999999999999999999999999999999999999999999999999999999990000000
00000000000000000000000000000000000000000000000000000000000000898888888988888889888888898888888988888889888888898888888988000000
00000000000000000000000000000000000000000000000000000000000009999999999999999999999999999999999999999999999999999999999999900000
00000000000000000000000000000000000000000000000000000000000088888889888888898888888988888889888888898888888988888889888888890000
00000000000000000000000000000000000000000000000000000000000999999999999999999999999999999999999999999999999999999999999999999000
00000000000000000000000000000000000000000000000000000000008888898888888988888889888888898888888988888889888888898888888988888800
00000000000000000000000000000000000000000000000000000000099999999999999999999999999999999999999999999999999999999999999999999990
00000000000000000000000000000000000000000000000000000000888988888889888888898888888988888889888888898888888988888889888888898888
00000000000000000000000000000000000000000000000000000000555555550000000055555555000000005555555500000000555555550000000055555555
00000000000000000000000000000000000000000000000000000000777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000000000000000000000000005777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000000000000000000000000050777777750000000077777775000000007777777500000000777777750000000077777775
00000000000000000000000000000000000000000000000000000500555555550000000055555555000000005555555500000000555555550000000055555555
00000000000000000000000000000000000000000000000000000050777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000000000000000000000000505777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000000000000000000000005000777577770000000077757777000000007775777700000000777577770000000077757777
00000000000000000000000000000000000000000000000000050000555555555555555555555555555555555555555555555555555555555555555555555555
00000000000000000000000000000000000000000000000050500000077777757777777577777775777777757777777577777775777777757777777577777770
00000000000000000000000000000000000000000000000505000000007777757777777577777775777777757777777577777775777777757777777577777700
00000000000000000000000000000000000000000000005000500000000777757777777577777775777777757777777577777775777777757777777577777000
00000000000000000000000000000000000000000000050005000000000055555555555555555555555555555555555555555555555555555555555555550000
00000000000000000000000000000000000000000000005050000000000007777775777777757777777577777775777777757777777577777775777777700000
00000000000000000000000000000000000000000000050500000000000000777775777777757777777577777775777777757777777577777775777777000000
00000000000000000000000000000000000000000000500000000000000000077775777777757777777577777775777777757777777577777775777770000000
00000000000000000000000000000000000000000005000000000000000800005555555555555555555555550000000000000000000000005555555500000000
00000000000000000000000000000000000000005050000000000000000880007777777577777775777777700000000000000000000000007777777500000000
000000000000000000000000000000000000000505000000000000000009a0007777777577777775777777000000000000000000000000007777777500000000
00000000000000000000000000000000000000500050000000000000000084007777777577777775777770000000000000000000000000007777777500000000
00000000000000000000000000000000000005000500000000000000000004005555555555555555555500000000000000000000000000005555555500000000
00000000000000000000000000000000000000505000000000000000000000407775777777757777777000000000000000000000000000007775777700000000
00000000000000000000000000000000000005050000000000000000000000457775777777757777770000000000000000000000000000007775777700000000
00000000000000000000000000000000000050000000000000000000000000057775777777757777700000000000000000000000000000007775777700000000
00000000000000000000000000000000000500000000000000000000000000005554055555555555000000000006000000000000000080005555555500000000
00000000000000000000000000000000505000000000000000000000000000007744447577777770000000000055600000000000000890007777777500000000
000000000000000000000000000000050500000000000000000000000000000074040405777777000000000005555600000000000008a0007777777500000000
00000000000000000000000000000050005000000000000000000000000000007445454577777000000000000567777000000000000084007777777500000000
00000000000000000000000000000500050000000000000000000000000000005404040555550000000000000506060700000000000004005555555500000000
00000000000000000000000000000050500000000000000000000000000000007445454777700000000000000566666000000000000000407775777700000000
00000000000000000000000000000505000000000000000000000000000000007404040777000000000000000555550000000000000000457775777700000000
00000000000000000000000000005000000000000000000000000000000000007445454770000000000000000555560000000000000000057775777700000000
0000000000000000000000000005000000000000004bb0070000000044000000540404050000000000000000566ddddd00000000000a00005554055500000000
000000000000000000000000505000000000000000b4bb070000000044888000744545450000000000000000555d567d0000000000a8a0007744447500000000
000000000000000000000005050000000000000000bbbbb70000000040666800740404050000000000000000666d567d0000000000a8a0007404040500000000
0000000000000000000000500050000000000000004f4f070000000040f8f600744545450000000000000000555d567d00000000000a00007445454500000000
0000000000000000000005000500000000000000004fff040000000040fff6005404040500000000000000005555d6d000000000000a00005404040500000000
0000000000000000000000505000000000000000fbbbbbb400000000f866688074454547000000000000000056056d0000000000000aa0007445454700000000
000000000000000000000505000000000000000000bbbb0000000000406688f07404040700000000000000005605600000000000000a00007404040700000000
00000000000000000000500000000000000000000040040000000000406688007444444700000000000000005565556000000000000aa0007445454700000000
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
11011000110110001101100011011000110110001101100011011000777777757777777577777775777777757777777577777775777777757777777577777775
c71c7111c71c7111c71c7111c71c7111c71c7111c71c7111c71c7111777777757777777577777775777777757777777577777775777777757777777577777775
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc555555555555555555555555555555555555555555555555555555555555555555555555
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777
cccccccccccccccccccccccccccccccccccccccccccccccccccccccc777577777775777777757777777577777775777777757777777577777775777777757777

__gff__
0001000000000000000000000101000001010002000100000000000000000000010002000001000000000000000000000100000100000000000000020200000000000000000100000000000000000000000000000001000000000000000000010000000000010000000000000000000100000000000100000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4143434343434343434343434343434200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5300000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5300000000000000000000000000005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5144444444444444444444444444445200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000003800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001e1f0000000000000000000000000000000000000000353436000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000002e2f0000000000000000000000000000000000000035343434360000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000003534343734343600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000353434343434343436000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000031110011001100110011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4546474800000000000000000000000000000000003132131111111111111122000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
555657580000003c3c3c3c000000000000000000313200191111220000001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6566676800000000000000000000000000000031320000001522004000191100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
75760e780e001d00000000000000000000003132000000072500005000051500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d0d0d0d0d00000d0d0d0d0d0d22303030303013111111111133042500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000d00000d000000000039393939393939111111111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000003c3c3c00000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d00000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000000000003c3c3c00000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d00000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000000000000000000000494a5c5d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0000000000000000000000595a6c6d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d0d0d11111111111111111111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0110010015550000000000018550000000000000000000001a55000500005001c5500050000500005001d5501c55000500005001a550005000050000500005001755000500005001355000500005000050015550
011000001755000500005001855000500005000050000500155500050000500155500050000500005001455015550005000050017550005000050000500005001455000500005001055000500005000050000500
0110000000000000000000009050000000000000000000000000000000000000c0500000000000000000000000000000000000007050000000000000000000000000000000000000705000000000000000000000
011000000000000000000000905000000000000000000000000000000000000090500000000000000000000000000000000000004050000000000000000000000000000000000000405000000000000000000000
__music__
00 01034344
02 02044344

