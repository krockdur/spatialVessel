


local Bullets = {}

--------------------------------------------------------------

local sprite

--------------------------------------------------------------

function Bullets.load()
  sprite = love.graphics.newImage("assets/bullets.png")
end


--------------------------------------------------------------



function Bullets.draw()

  for i,b in pairs(tab_bullets) do

    love.graphics.draw(sprite, b.x, b.y)

  end

end


--------------------------------------------------------------

function Bullets.update(dt)

  for i,b in pairs(tab_bullets) do

    b.y = b.y - b.speed

  end


end  

return Bullets