
local Background = {}

local sprite_bg
local sprite_bg_2
local sprite_asteroid_1

Background.tab_asteroids = {}
Background.x1 = 0
Background.y1 = -768        -- position de départ bg 1
Background.x2 = 0
Background.y2 = -768 - 1536 -- position de départ bg 2
Background.speed = 20

local delta_time_between_asteroid = 0
local timer_new_asteroid = 0
local asteroid_x_positions = { 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 }

function Background.load()

    sprite_bg = love.graphics.newImage("assets/background.png")
    sprite_bg_2 = love.graphics.newImage("assets/background.png")
    
    sprite_asteroid_1 = love.graphics.newImage("assets/asteroid.png")

end


function Background.update(dt)

    -- BG
    Background.y1 = Background.y1 + Background.speed * dt
    Background.y2 = Background.y2 + Background.speed * dt

    -- enchainement des bg
    if Background.y1 >= love.graphics.getHeight() + 10 then
        Background.y1 = -768 - 1536
    end

    if Background.y2 >= love.graphics.getHeight() + 10 then
        Background.y2 = -768 - 1536
    end

    -- ACTEROIDS
    Background.create_asteroid(dt)

    for i, e in pairs(Background.tab_asteroids) do
        e.y = e.y + Background.speed * 2 * dt

        -- suppression des astéroids hors écran
        if e.y > love.graphics.getHeight() + 300 then
        table.remove(Background.tab_asteroids, i)
        end
    end



end

function Background.draw()
    love.graphics.draw(sprite_bg, Background.x1, Background.y1)
    love.graphics.draw(sprite_bg_2, Background.x2, Background.y2)

    for i, e in pairs(Background.tab_asteroids) do

      love.graphics.draw(sprite_asteroid_1, e.x, e.y, e.a, e.s, e.s, sprite_asteroid_1:getWidth() / 2, sprite_asteroid_1:getHeight() / 2)

    end

end


local last_rand_tab_asteroid = 0
function Background.create_asteroid(dt)

    timer_new_asteroid = timer_new_asteroid + dt

    if timer_new_asteroid > delta_time_between_asteroid then

        timer_new_asteroid = 0;
        delta_time_between_asteroid = love.math.random(7, 12)

        local rand_tab_i = love.math.random(1, 11)
        while rand_tab_i>=last_rand_tab_asteroid -1 and rand_tab_i <= last_rand_tab_asteroid + 1  do
            rand_tab_i = love.math.random(1, 11)
        end
        table.insert(Background.tab_asteroids, {
            x = love.math.random(asteroid_x_positions[rand_tab_i], asteroid_x_positions[rand_tab_i] + 1),
            y = -300,
            a = love.math.random(0, 2*math.pi),
            s = love.math.random(0.4, 2)
        })
        last_rand_tab_asteroid = rand_tab_i

    end

end


return Background