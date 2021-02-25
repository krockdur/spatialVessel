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
love.graphics.setDefaultFilter('nearest')

local gameIsPaused = false


-- Initilisation
function love.load()
  screenManager.load()
end


-- on dessine la vue
function love.draw()
  screenManager.draw()
end



-- Boucle
function love.update(dt)
  -- Mise en pause en fonction du focus
  if gameIsPaused then return end

  screenManager.update(dt)

end


-- les contrôles
function love.mousepressed(x, y, button, istouch)
  screenManager.mousepressed(x, y, button, istouch)
end

function love.mousereleased(x, y, button, istouch)
  screenManager.mousereleased(x, y, button, istouch)
end

function love.keypressed(key)
  screenManager.keypressed(key)
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
