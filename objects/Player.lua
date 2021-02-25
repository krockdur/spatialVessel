local Player = {}

Player.x = 400
Player.y = 600

local sprite

---------------------------------------------------

function Player.load()
  sprite = love.graphics.newImage("assets/vessel.png")
end

---------------------------------------------------



function Player.draw()

  love.graphics.draw(sprite, Player.x, Player.y)

end

---------------------------------------------------

function Player.update(dt)


end
----------------------------------------------

return Player








---------------------------------------------------