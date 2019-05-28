_G.max = math.max
_G.flr = math.floor

_G.all = function(t)
  local i = 0
  local n = #t
  return function ()
    i = i + 1
    if i <= n then return t[i] end
  end
end

_G.btnp = function()
  return false
end

_G.btn = function()
  return false
end

_G.menuitem = function()
end

_G.mget = function()
  return 1
end

_G.fget = function()
  return true
end

