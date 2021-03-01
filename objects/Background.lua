
local Background = {}

local sprite_bg

function Background.load()

    sprite_bg = love.graphics.newImage("assets/background.png")

end

function Background.update()

end

function Background.draw()
    love.graphics.draw(sprite_bg, 0, 0)
end

return Background