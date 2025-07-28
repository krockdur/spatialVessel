

local UI = {}

local sprite_target

function UI.load()
    sprite_target = love.graphics.newImage("assets/target.png")
end

function UI.update(dt)

end

function UI.draw()

    love.graphics.draw(sprite_target, love.mouse.getX(), love.mouse.getY(), 0, 1, 1, sprite_target:getWidth()/2, sprite_target:getHeight()/2)

end



return UI