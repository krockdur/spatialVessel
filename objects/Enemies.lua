


local Enemies = {}

Enemies.list = {}

-- pattern d'apparition des ennemies
-- n => nombre d'ennemies dans la vague
-- t => temps en seconde avant l'apparition de la vague
-- v => type de l'enemie
-- pv => pv par enemie de la vague
Enemies.pattern = {
  {
    n=1, t=1, v=1, pv=1
  },
  {
    n=2, t=1, v=2, pv=2
  },
  {
    n=3, t=1, v=1, pv=1
  },
  {
    n=4, t=1, v=1, pv=1
  },
  {
    n=5, t=1, v=2, pv=2
  },
  {
    n=3, t=3, v=1, pv=1
  },
  {
    n=2, t=5, v=1, pv=1
  },
  {
    n=4, t=5, v=1, pv=1
  },
  {
    n=5, t=5, v=1, pv=1
  }
}

--------------------------------------------------------------

local sprite_enemy_1
local sprite_enemy_2

--------------------------------------------------------------

function Enemies.load()
  sprite_enemy_1 = love.graphics.newImage("assets/enemy1.png")
  sprite_enemy_2 = love.graphics.newImage("assets/enemy2.png")
end


--------------------------------------------------------------



function Enemies.draw()

  if #Enemies.list > 0 then
    for i, e in pairs(Enemies.list) do

      if e.type == 1 then
      love.graphics.draw(sprite_enemy_1, e.x, e.y)
      end
      if e.type == 2 then
        love.graphics.draw(sprite_enemy_2, e.x, e.y)
      end        

      if DEBUG_GAME == true then
        love.graphics.rectangle("line", e.x, e.y, 64, 64)
      end
    end
  end

end


--------------------------------------------------------------

local indice_vague = 1
local delta_time = Enemies.pattern[1].t
local timer_vague = 0

local timer_evolution_enemies = 0

function Enemies.update(dt)


  -- évolution des ennemies
  for i, e in pairs(Enemies.list) do
    e.y = e.y + e.speed * dt
  end



  -- apparition des ennemies
  timer_vague = timer_vague + dt
  

  --
  if timer_vague >= delta_time then

    local nb_enemies = Enemies.pattern[indice_vague].n
    local type_enemies = Enemies.pattern[indice_vague].v
    local pv_enemies = Enemies.pattern[indice_vague].pv

    -- calcul écart des énemies
    local nb_ecarts = nb_enemies + 1
    local ecart_pixel = (love.graphics.getWidth() - (nb_enemies * 64)) / nb_ecarts

    -- creation des enemies
    for i = 1, nb_enemies do

      table.insert(Enemies.list, {

        x = ecart_pixel * i + (i -1) * 64,
        y = -64,
        speed = 60,
        pv = pv_enemies,
        type=type_enemies

      })

    end

    indice_vague = indice_vague + 1
    delta_time = Enemies.pattern[indice_vague].t
    timer_vague = 0
    if indice_vague > #Enemies.pattern then
      indice_vague = 1
    end

  end


end

return Enemies