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

local limit_fps = 60

local test_delta_fps = 0


local show_dt = 0
local tmp_dt = 0


-- Initilisation
function love.load()
  love.keyboard.setKeyRepeat(true)
  
  screenManager.load()
end


local delta_fps
-- on dessine la vue
function love.draw()
  screenManager.draw()
  
  -- love.graphics.print("Current FPS: "..tostring(love.timer.getFPS()), 10, 10)
  -- love.graphics.print("Game FPS: "..tostring(test_delta_fps), 10, 40)
end



-- Boucle
local stack_dt = 0
local test_fps = 0
local count_frame = 0

function love.update(dt)
  
  -- Mise en pause en fonction du focus
  if gameIsPaused then return end

  -- Comptage nombre d'appel par seconde de screenManager.update
  test_fps = test_fps + dt
  if test_fps >= 1 then
    test_fps = test_fps - 1
    test_delta_fps = count_frame
    count_frame = 0
  end
  
  -- Appel de screenManager.update 60 fois par seconde
  stack_dt = stack_dt + dt
  if stack_dt >= 1/limit_fps then

    stack_dt = stack_dt - 1/limit_fps

    screenManager.update(1/limit_fps)

    count_frame = count_frame + 1

  end

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

function  love.touchpressed( id, x, y, dx, dy, pressure )
  screenManager.touchpressed( id, x, y, dx, dy, pressure )
end

function love.touchmoved( id, x, y, dx, dy, pressure )
  screenManager.touchmoved( id, x, y, dx, dy, pressure )
end

function love.touchreleased( id, x, y, dx, dy, pressure )
  screenManager.touchreleased( id, x, y, dx, dy, pressure )
end


function love.joystickadded( pad )
  if pad:isGamepad() then
    print ("GamePad added")
  end
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
