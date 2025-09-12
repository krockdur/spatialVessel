

local UI = {}

local sprite_target

UI.score = 0

UI.input = {}

UI.input.pad_left = {}
UI.input.pad_left.show = false
UI.input.pad_left.x = 0
UI.input.pad_left.y = 0
UI.input.pad_left.radius = 30

UI.input.pad_right = {}
UI.input.pad_right.show = false
UI.input.pad_right.x = 0
UI.input.pad_right.y = 0
UI.input.pad_right.radius = 30



function UI.load()
    sprite_target = love.graphics.newImage("assets/target.png")
end

function UI.update(dt)

end

function UI.draw()

    love.graphics.draw(sprite_target, love.mouse.getX(), love.mouse.getY(), 0, 1, 1, sprite_target:getWidth()/2, sprite_target:getHeight()/2)
    love.graphics.print("SCORE: "..tostring(UI.score), 10, 10)
    if UI.input.pad_left.show then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle( "line", UI.input.pad_left.x, UI.input.pad_left.y, UI.input.pad_left.radius, 100 )
    end
    if UI.input.pad_right.show then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle( "line", UI.input.pad_right.x, UI.input.pad_right.y, UI.input.pad_right.radius, 100 )
    end
end

function UI.touchpressed( id, x, y, dx, dy, pressure )

    if x < love.graphics.getWidth() / 2 then
        UI.input.pad_left.x = x
        UI.input.pad_left.y = y
        UI.input.pad_left.show = true
    else
        UI.input.pad_right.x = x
        UI.input.pad_right.y = y
        UI.input.pad_right.show = true
    end

end

function UI.touchreleased( id, x, y, dx, dy, pressure )
    if x < love.graphics.getWidth() / 2 then
        UI.input.pad_left.show = false
    else
        UI.input.pad_right.show = false
    end
end

return UI