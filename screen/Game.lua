
local player = require("objects.Player")
local enemies = require("objects.Enemies")

local Game = {}

DEBUG_GAME = true

-----------------------------------------------------------------------

function Game.load()

  player.load()
  enemies.load()

end

-----------------------------------------------------------------------


function Game.draw()
  player.draw()
  enemies.draw()
  if DEBUG_GAME == true then
    love.graphics.rectangle("line", 0, 0, 512, 768)
  end

end

-----------------------------------------------------------------------
-- r1{x, y, w, h}
-- r2{x, y, w, h}
local function check_collision(r1, r2)

  -- enemies rectangle
  local p0x = r1.x
  local p0y = r1.y + 64
  local p1x = r1.x + 64
  local p1y = r1.y

  -- bullet rectangle
  local p2x = r2.x
  local p2y = r2.y + player.sprite_bullet_h
  local p3x = r2.x + player.sprite_bullet_w
  local p3y = r2.y

  if
  p2x > p1x or
  p3x < p0x or
  p2y < p1y or
  p3y > p0y  then
    return false
  else
    return true
  end



end


function Game.update(dt)

  player.update(dt)
  enemies.update(dt)

  -- check collision

  local tab_enemies_to_remove = {}
  if #enemies.list ~= 0 and #player.tab_bullets ~= 0 then
    for j, e in pairs(enemies.list) do
      for i, b in pairs(player.tab_bullets) do


        local test = check_collision(enemies.list[j], player.tab_bullets[i])

        if test == true then

          print("coll")
          e.pv = e.pv - 1
          if e.pv <= 0 then
            table.remove(enemies.list, j)
          end
          table.remove(player.tab_bullets, i)
          break
        end

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