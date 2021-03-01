


local Enemies = {}

Enemies.list = {}

Enemies.tab_bullets = {}

Enemies.sprite_w = 64
Enemies.sprite_h = 64

-- pattern d'apparition des ennemies
-- number           => nombre d'ennemies dans la vague
-- period           => temps en seconde avant l'apparition de la vague
-- type             => type de l'enemie. sprite_enemy_x => type=x
-- pv               => pv par enemie de la vague
-- pattern_move     => type de déplacement. 1=>y+ 2=>x+y+ 3=>x-y+
Enemies.pattern = {
  {
    number=1, period=1, type=1, pv=1, pattern_move=1, fire=1
  },
  {
    number=2, period=1, type=2, pv=2, pattern_move=2, fire=0
  },
  {
    number=3, period=1, type=1, pv=1, pattern_move=1, fire=1
  },
  {
    number=4, period=1, type=1, pv=1, pattern_move=3, fire=0
  },
  {
    number=5, period=1, type=2, pv=2, pattern_move=1, fire=1
  },
  {
    number=3, period=3, type=1, pv=1, pattern_move=1, fire=0
  },
  {
    number=2, period=5, type=1, pv=1, pattern_move=1, fire=1
  },
  {
    number=4, period=5, type=1, pv=1, pattern_move=1, fire=0
  },
  {
    number=5, period=5, type=1, pv=1, pattern_move=1, fire=1
  }
}

--------------------------------------------------------------

local sprite_enemy_1
local sprite_enemy_2
local sprite_bullets

--------------------------------------------------------------

function Enemies.load()
  sprite_enemy_1 = love.graphics.newImage("assets/enemy1.png")
  sprite_enemy_2 = love.graphics.newImage("assets/enemy2.png")
  sprite_bullets = love.graphics.newImage("assets/bullets_enemy_1.png")
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

      for j,b in pairs(Enemies.tab_bullets) do

        love.graphics.draw(sprite_bullets, b.x, b.y)
        if DEBUG_GAME == true then
          love.graphics.rectangle("line", b.x, b.y, 32, 32)
        end
      end

    end



  end

end


--------------------------------------------------------------

local indice_vague = 1
local delta_time = Enemies.pattern[1].period
local timer_vague = 0

local timer_evolution_enemies = 0
local pattern_2_direction = 0
local pattern_3_direction = 1

local timerShooter = 0
function Enemies.update(dt)


  -- DEPLACEMENT DES ENNEMIES
  for i, e in pairs(Enemies.list) do

    if e.pattern_move == 1 then
      e.y = e.y + e.speed * dt
    end

    if e.pattern_move == 2 then

      if e.x >= (love.graphics.getWidth() - Enemies.sprite_w) and pattern_2_direction == 0 then
        pattern_2_direction = 1
      end

      if e.x <= (0 + Enemies.sprite_w) and pattern_2_direction == 1 then
        pattern_2_direction = 0
      end

      if pattern_2_direction == 0 then
        e.x = e.x + e.speed * dt
      else
        e.x = e.x - e.speed * dt
      end
      e.y = e.y + e.speed * dt
    end

    if e.pattern_move == 3 then

      if e.x >= (love.graphics.getWidth() - Enemies.sprite_w) and pattern_3_direction == 0 then
        pattern_3_direction = 1
      end

      if e.x <= (0 + Enemies.sprite_w) and pattern_3_direction == 1 then
        pattern_3_direction = 0
      end

      if pattern_3_direction == 0 then
        e.x = e.x + e.speed * dt
      else
        e.x = e.x - e.speed * dt
      end
      e.y = e.y + e.speed * dt
    end

    -- TIR DES ENNEMIES
    timerShooter = timerShooter + dt
    if timerShooter >= 2 then

      if e.type_fire ~= 0 then
        table.insert(Enemies.tab_bullets, {

          x = e.x + 16,
          y = e.y,
          speed = 60
    
        })
      end

      timerShooter = 0
    end
    
    -- DEPLACEMENT DES BULLETS
    for j,b in pairs(Enemies.tab_bullets) do

      -- si la bullet sort de l'écran
      if b.y > love.graphics.getHeight() then
        table.remove(Enemies.tab_bullets, j)
      end

      b.y = b.y + b.speed * dt
    end

  end



  -- apparition des ennemies
  timer_vague = timer_vague + dt
  

  --
  if timer_vague >= delta_time then

    local nb_enemies = Enemies.pattern[indice_vague].number
    local type_enemies = Enemies.pattern[indice_vague].type
    local pv_enemies = Enemies.pattern[indice_vague].pv
    local pattern_move = Enemies.pattern[indice_vague].pattern_move
    local type_fire = Enemies.pattern[indice_vague].fire
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
        type = type_enemies,
        pattern_move = pattern_move,
        type_fire = type_fire
      })

    end

    indice_vague = indice_vague + 1
    delta_time = Enemies.pattern[indice_vague].period
    timer_vague = 0
    if indice_vague > #Enemies.pattern then
      indice_vague = 1
    end

  end


end

return Enemies