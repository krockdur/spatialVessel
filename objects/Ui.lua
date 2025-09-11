

local UI = {}

local sprite_target

UI.score = 0

UI.input = {}
UI.input.position_pad_left = {}
UI.input.position_pad_left.show = false
UI.input.position_pad_left.x = 0
UI.input.position_pad_left.y = 0
UI.input.position_pad_left.radius = 30


function UI.load()
    sprite_target = love.graphics.newImage("assets/target.png")
end

function UI.update(dt)

end

function UI.draw()

    love.graphics.draw(sprite_target, love.mouse.getX(), love.mouse.getY(), 0, 1, 1, sprite_target:getWidth()/2, sprite_target:getHeight()/2)
    love.graphics.print("SCORE: "..tostring(UI.score), 10, 10)
    if UI.input.position_pad_left.show then
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle( "line", UI.input.position_pad_left.x, UI.input.position_pad_left.y, UI.input.position_pad_left.radius, 100 )
    end
end

function UI.touchpressed( id, x, y, dx, dy, pressure )
    UI.input.position_pad_left.x = x
    UI.input.position_pad_left.y = y
    UI.input.position_pad_left.show = true
end


function UI.touchreleased( id, x, y, dx, dy, pressure )
    UI.input.position_pad_left.show = false
end

return UI