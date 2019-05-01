-- main

local v_0 = 4
local acc = -0.33
local dx_max=1

local joy_left=0
local joy_right=1
local joy_up=2
local joy_down=3
local joy_o=4
local joy_x=5

function _init()
  show_graph=false
  show_dot=false
  show_collision_points=false
  play_music=false
  menuitem(1,"reset",_init)
  menuitem(2,"toggle music",toggle_music)
  menuitem(3,"toggle graph",toggle_graph)
  menuitem(4,"toggle collision_points",toggle_collision_points)
  menuitem(5,"toggle dot",toggle_dot)
  game:init()
  tiles:init()
  player:init()
end

function _draw()
  camera()
  cls()
  draw_hud()
  local camera_x,camera_y=game:room_camera()
  map(camera_x/8,4+camera_y/8,0,32,16,12)
  player:draw()
  game:draw_mobs()
  if player.is_talking then
    draw_dialog()
  end
  if show_graph then
    graphic:draw_plot_background()
    graphic:draw_gravity_plot()
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
    game:update_mobs()
    player:update()
  end
end
