
local player = require("objects.Player")
local enemies = require("objects.Enemies")
local background = require("objects.Background")
local ui = require("objects.Ui")

local Game = {}

DEBUG_GAME = false

local sound_touch_1
local sprite_explosion_1
local sprite_explosion_2
local sprite_explosion_3


Game.score = 0
function Game.calculate_score(value)
  Game.score = Game.score + value
  ui.score = Game.score
end
-----------------------------------------------------------------------

function Game.load()

  sound_touch_1 = love.audio.newSource("assets/sounds/touch1.wav", "static")
  sprite_explosion_1 = love.graphics.newImage("assets/explosion1.png")
  sprite_explosion_2 = love.graphics.newImage("assets/explosion2.png")
  sprite_explosion_3 = love.graphics.newImage("assets/explosion3.png")

  background.load()
  player.load()
  enemies.load()
  ui.load()

end

-----------------------------------------------------------------------

function Game.update(dt)

  background.update(dt)
  player.update(dt)
  enemies.update(dt)
  Game.update_collision(dt)
  Game.animate_explosion(dt)
  ui.update(dt)

end

-----------------------------------------------------------------------

function Game.draw()
  background.draw()
  player.draw()
  enemies.draw()
  Game.draw_anim_explosion()
  ui.draw()
end

-----------------------------------------------------------------------

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

-----------------------------------------------------------------------

function Game.update_collision(dt)
    -- check collision

    if #enemies.list ~= 0 and #player.tab_bullets ~= 0 then
      for j, e in pairs(enemies.list) do
        for i, b in pairs(player.tab_bullets) do
  
          if check_collision(enemies.list[j], player.tab_bullets[i]) then
            e.pv = e.pv - 1
            
            sound_touch_1:stop()
            sound_touch_1:play()
  
            -- animation si énnemie touché
            Game.add_anim_explosion(e.x, e.y)
  
            if e.pv <= 0 then

              Game.calculate_score(e.points)

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

Game.tab_explosion = {}
function Game.add_anim_explosion(x, y)

  table.insert(Game.tab_explosion, {
    x=x+16,
    y=y+16,
    state=0
  })

end

local timer_explosion = 0
function Game.animate_explosion(dt)

  timer_explosion = timer_explosion + dt
  if timer_explosion >= 0.05 then
    for i,e in pairs(Game.tab_explosion) do
      e.state = e.state + 1
      timer_explosion = 0
      if e.state > 3 then
        table.remove(Game.tab_explosion, i)
        
      end
    end
  end

end

function Game.draw_anim_explosion()
  for i, e in pairs(Game.tab_explosion) do

    if e.state == 1 then
      love.graphics.draw(sprite_explosion_1, e.x, e.y)
    end
    if e.state == 2 then
      love.graphics.draw(sprite_explosion_2, e.x, e.y)
    end
    if e.state == 3 then
      love.graphics.draw(sprite_explosion_3, e.x, e.y)
    end

  end
end

-----------------------------------------------------------------------

function Game.keypressed(key, scancode, isrepeat)
  player.keypressed(key, scancode, isrepeat)
end

-----------------------------------------------------------------------

function Game.mousepressed(x, y, button, istouch)
  
end

-----------------------------------------------------------------------
function Game.touchpressed( id, x, y, dx, dy, pressure )
  if (x < love.graphics.getWidth() / 2) then

  end
  ui.touchpressed( id, x, y, dx, dy, pressure )
end

-----------------------------------------------------------------------
function Game.touchmoved( id, x, y, dx, dy, pressure )
  player.touchmoved( id, x, y, dx, dy, pressure )
end

function Game.touchreleased( id, x, y, dx, dy, pressure )
  player.touchreleased( id, x, y, dx, dy, pressure )
  ui.touchreleased( id, x, y, dx, dy, pressure )
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