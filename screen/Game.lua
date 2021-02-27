
local player = require("objects.Player")
local enemies = require("objects.Enemies")

local Game = {}


-----------------------------------------------------------------------

function Game.load()

  player.load()
  enemies.load()

end

-----------------------------------------------------------------------


function Game.draw()
  player.draw()
  enemies.draw()
  
end

-----------------------------------------------------------------------



function Game.update(dt)

  player.update(dt)
  enemies.update(dt)
  
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