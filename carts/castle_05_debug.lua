-->8
-- debug

function update_graph_values()
  if btn(joy_left) then
    v_0 = v_0 - .1
  end
  if btn(joy_right) then
    v_0 = v_0 + .1
  end
  if btn(joy_up) then
    acc = min(0,acc + .01)
  end
  if btn(joy_down) then
    acc = acc-.01
  end
  if btn(joy_x) then
    dx_max = dx_max + .01
  end
  if btn(joy_o) then
    dx_max = max(0.1,dx_max-.01)
  end
end

---
-- Menu actions

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
