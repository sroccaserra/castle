-->8
-- tiles

tiles={}

function tiles:init()
  self.swap_counter=0
end

function tiles:update()
  game:swap_tiles(25,26)
  game:swap_tiles(57,58)
  self.swap_counter=self.swap_counter+1
end


function is_solid(x,y)
  local tile=game:get_tile(x,y)
  return fget(tile,0)
end

function is_floor(x,y)
  local tile=game:get_tile(x,y)
  return fget(tile,1)
end

function is_npc(x,y)
  return 7 == game:get_tile(x,y)
end

function swap_tile(offset,first,second)
  local tile=peek(offset)
  if tile == first then
    poke(offset,second)
  elseif tile == second then
    poke(offset,first)
  end
end
