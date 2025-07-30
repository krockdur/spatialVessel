--[[

Project: skeleton love2D
Version: v0.1
Author : Julien Fougery


Versions :
lua : 5.4.2
love2d : 	11.3

]]

local screenManager = require('screen.ScreenManager')

-- meilleur rendu avec du pixel art
--love.graphics.setDefaultFilter('nearest')

local gameIsPaused = false

local time_start = 0
local time_end = 0

local test_fps = 0
local test_delta_fps = 0
local count_frame = 0

-- Initilisation
function love.load()
  love.keyboard.setKeyRepeat(true)

  love.window.setVSync(1)
  
  screenManager.load()
end

local delta_fps
-- on dessine la vue
function love.draw()
  screenManager.draw()
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
  --love.graphics.print("Delta FPS: "..tostring(delta_fps), 10, 50)

  love.graphics.print("Delta FPS: "..tostring(test_delta_fps), 10, 80)
end



-- Boucle

local limit_fps = 60


local stack_dt = 0

function love.update(dt)

  -- Mise en pause en fonction du focus
  if gameIsPaused then return end

  test_fps = test_fps + dt
  if test_fps >= 1 then
    test_fps = test_fps - 1
    test_delta_fps = count_frame
    count_frame = 0
  end
  


  stack_dt = stack_dt + dt
  if stack_dt >= 1/limit_fps then
    time_end = time_start
    time_start = love.timer.getTime()

    stack_dt = stack_dt - 1/limit_fps
    screenManager.update(dt)
    count_frame = count_frame + 1

    -- time_end = love.timer.getTime()
  end

  --delta_fps = love.timer.getDelta()

  




end


-- les contrôles
function love.mousepressed(x, y, button, istouch)
  screenManager.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
  screenManager.mousereleased(x, y, button, istouch)
end

function love.keypressed(key, scancode, isrepeat)
  screenManager.keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key)
  screenManager.keyreleased(key)
end

function love.mousemoved(x, y, dx, dy, istouch)
  
  screenManager.mousemoved(x, y, dx, dy, istouch)
  
end


-- function love.focus(f) gameIsPaused = not f end
function love.focus(f)
  if not f then
    print("focus perdu")
    gameIsPaused = true
  else
    gameIsPaused = false
    print("focus fenetre")
  end
end



function love.quit()
  print("END GAME")
end
