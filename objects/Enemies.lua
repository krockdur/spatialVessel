


local Enemies = {}

Enemies.list = {}

--------------------------------------------------------------

local sprite_enemy_1

--------------------------------------------------------------

function Enemies.load()
  sprite_enemy_1 = love.graphics.newImage("assets/enemy1.png")

  math.randomseed(os.time())
  
  for i = 1,30 do

    table.insert(Enemies.list, {

      x = math.random(1, 1000),
      y = -20,
      speed = 0.5

    })
    
  end

end


--------------------------------------------------------------



function Enemies.draw()

  for i, e in pairs(Enemies.list) do
    love.graphics.draw(sprite_enemy_1, e.x, e.y)
  end

end


--------------------------------------------------------------

function Enemies.update(dt)

  for i, e in pairs(Enemies.list) do
    e.y = e.y + e.speed
  end


end  

return Enemies