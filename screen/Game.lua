
local player = require("objects.Player")
local enemies = require("objects.Enemies")

local Game = {}

debug = true

-----------------------------------------------------------------------

function Game.load()

  player.load()
  enemies.load()

end

-----------------------------------------------------------------------


function Game.draw()
  player.draw()
  enemies.draw()
  if debug == true then
    love.graphics.rectangle("line", 0, 0, 512, 768)
  end

end

-----------------------------------------------------------------------
-- r1{x, y, w, h}
-- r2{x, y, w, h}
local function check_collision(r1, r2)

  local l1x = r1.x
  local l2x = r2.x
  local r1x = l1x + 64
  local r2x = l2x + 64
  local l1y = r1.y
  local l2y = r2.y
  local r1y = l1y +64
  local r2y = l2y + 64

  if (l1x >= r2x or l2x >= r1x) then
      print("A")
      return false; 
  end

  if (l1y <= r2y or l2y <= r1y) then
    print("B")
      return false; 
  end

  print("C")
  return true; 

end


local wanted_fps = 60

function Game.update(dt)

  player.update(dt)
  enemies.update(dt)

  -- check collision

  for j, e in pairs(enemies.list) do
    for i, b in pairs(player.tab_bullets) do 


      local test = check_collision(
        {x=player.tab_bullets[i].x, y=player.tab_bullets[i].y, w=player.tab_bullets[i].x + 64, h=player.tab_bullets[i].y + 64},
        {x=enemies.list[j].x, y=enemies.list[j].y, w=enemies.list[j].x + 64, h=enemies.list[j].y + 64}
      )

      if test == true then
        table.remove(enemies.list, j)
      end

    end

  end

end



-----------------------------------------------------------------------

function Game.keypressed(key)
  
end

-----------------------------------------------------------------------

function Game.mousepressed(x, y, button, istouch)
  
end

-----------------------------------------------------------------------

-- generate random number from 1 -> 6
function Game.pickUpRandRecipe()
  math.randomseed(os.time())
  return math.random(1, 6)
end

-----------------------------------------------------------------------

function Game.mousemoved(x, y, dx, dy, istouch)
  player.mousemoved(x, y, dx, dy, istouch)
end

-----------------------------------------------------------------------

return Game