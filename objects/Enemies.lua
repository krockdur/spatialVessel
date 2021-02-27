


local Enemies = {}

Enemies.list = {}

-- pattern d'apparition des ennemies
-- n => nombre d'ennemies dans la vague
-- t => temps en seconde avant l'apparition de la vague
Enemies.pattern = {
  {
    n=3,
    t=3
  },
  {
    n=2,
    t=15
  },
  {
    n=2,
    t=15
  },
  {
    n=2,
    t=15
  }
}

--------------------------------------------------------------

local sprite_enemy_1

--------------------------------------------------------------

function Enemies.load()
  sprite_enemy_1 = love.graphics.newImage("assets/enemy1.png")
end


--------------------------------------------------------------



function Enemies.draw()

  if #Enemies.list > 0 then
    for i, e in pairs(Enemies.list) do
      love.graphics.draw(sprite_enemy_1, e.x, e.y)
    end
  end

end


--------------------------------------------------------------

local indice_vague = 1
local delta_time = Enemies.pattern[1].t
local timer_vague = 0
function Enemies.update(dt)

  -- évolution des ennemies
  for i, e in pairs(Enemies.list) do
    e.y = e.y + e.speed
  end

  -- apparition des ennemies
  timer_vague = timer_vague + dt
  print(tostring(timer_vague))

  if timer_vague >= delta_time then

    delta_time = Enemies.pattern[indice_vague].t
    timer_vague = 0
    math.randomseed(os.time())
    for i = 1, Enemies.pattern[indice_vague].n do
      
      table.insert(Enemies.list, {

        x = math.random(200, 800),
        y = -64,
        speed = 0.5

      })
    end

    indice_vague = indice_vague + 1
    if indice_vague > #Enemies.pattern then
      indice_vague = 1
    end

  end





end  

return Enemies