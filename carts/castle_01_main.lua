-- main

v_0 = 4
acc = -0.33
dx_max = 1

joy_left = 0
joy_right = 1
joy_up = 2
joy_down = 3
joy_o = 4
joy_x = 5

function _init()
  show_graph = false
  show_dot = false
  show_collision_points = false
  play_music = false
  menuitem(1, "reset", _init)
  menuitem(2, "toggle music", toggle_music)
  menuitem(3, "toggle graph", toggle_graph)
  menuitem(4, "toggle collision_points", toggle_collision_points)
  menuitem(5, "toggle dot", toggle_dot)
  game:init()
  tiles:init()
  player:init()
  scene = game
end

function _draw()
  scene:draw()
end

function _update60()
  scene:update()
end


---
-- death screen

local death_screen = {}

function death_screen:draw()
  cls()
  print("you are dead", 36, 63, 8)
end

function death_screen:update()
  if btnp(joy_o) or btnp(joy_x) then
    _init()
  end
end

function goto_death_screen()
  scene = death_screen
end
