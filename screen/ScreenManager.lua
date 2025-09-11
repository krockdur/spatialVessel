
local menu = require('screen.Menu')
local credits = require('screen.Credits')
local game = require('screen.Game')
local options = require('screen.Options')
local score = require('screen.Score')

local ScreenManager = {}

ScreenManager.screen = "game"




function ScreenManager.load()

  menu.load()
  game.load()
  score.load()
  credits.load()
  options.load()

end

function ScreenManager.draw()

  if ScreenManager.screen == "menu" then
    menu.draw()
  end

  if ScreenManager.screen == "game" then
    game.draw()
  end

  if ScreenManager.screen == "score" then
    score.draw()
  end

  if ScreenManager.screen == "credit" then
    credits.draw()
  end

  if ScreenManager.screen == "options" then
    options.draw()
  end

end

function ScreenManager.update(dt)

  if ScreenManager.screen == "menu" then
    menu.update(dt)
  end

  if ScreenManager.screen == "game" then
    game.update(dt)      
  end

  if ScreenManager.screen == "score" then
    score.update(dt)
  end

  if ScreenManager.screen == "credit" then
    credits.update(dt)
  end

  if ScreenManager.screen == "options" then
    options.update(dt)
  end



end


function ScreenManager.mousepressed(x, y, button, istouch)
  if ScreenManager.screen == "game" then
    game.mousepressed(x, y, button, istouch) 
  end
end

function ScreenManager.mousereleased(x, y, button, istouch)
end

function ScreenManager.keypressed(key, scancode, isrepeat)
  game.keypressed(key, scancode, isrepeat)

    if key == "tab" then
      local state = not love.mouse.isVisible()   -- the opposite of whatever it currently is
      love.mouse.setVisible(state)
    end
   
end

function ScreenManager.touchpressed( id, x, y, dx, dy, pressure )
  if ScreenManager.screen == "game" then
    game.touchpressed( id, x, y, dx, dy, pressure )
  end
end

function ScreenManager.touchmoved( id, x, y, dx, dy, pressure )
  if ScreenManager.screen == "game" then
    game.touchmoved( id, x, y, dx, dy, pressure )
  end
end

function ScreenManager.touchreleased( id, x, y, dx, dy, pressure )
    if ScreenManager.screen == "game" then
      game.touchreleased( id, x, y, dx, dy, pressure )
    end
end

function ScreenManager.keyreleased(key)
end

function ScreenManager.mousemoved(x, y, dx, dy, istouch)
  if ScreenManager.screen == "game" then
    game.mousemoved(x, y, dx, dy, istouch)      
  end
end


return ScreenManager