local Player = require "objects.Player"



local Enemies = {}

Enemies.list = {}

Enemies.tab_bullets = {}

Enemies.sprite_w = 64
Enemies.sprite_h = 64

Enemies.shoot_interval = 0.2 -- en secondes
Enemies.shoot_speed = 400
Enemies.speed = 150

-- pattern d'apparition des ennemies
-- number           => nombre d'ennemies dans la vague
-- period           => temps en seconde avant l'apparition de la vague
-- type             => type de l'enemie. sprite_enemy_x => type=x
-- pv               => pv par enemie de la vague
-- pattern_move     => type de déplacement. 1=>y+ 2=>x+y+ 3=>x-y+
-- fire
-- points           => Nombre de points gagné quand pv arrive a 0
Enemies.pattern = {
  {
    number=1, period=2, type=1, pv=1, pattern_move=1, fire=1, points=1
  },
  {
    number=4, period=1, type=2, pv=2, pattern_move=1, fire=0, points=2
  },
  {
    number=2, period=1, type=2, pv=3, pattern_move=3, fire=1, points=3
  },
  {
    number=3, period=1, type=1, pv=1, pattern_move=3, fire=1, points=1
  },
  {
    number=2, period=1, type=2, pv=2, pattern_move=3, fire=0, points=2
  }
}

-- =================================================================== --

local sprite_enemy_1
local sprite_enemy_2
local sprite_bullets

-- =================================================================== --

function Enemies.load()
  sprite_enemy_1 = love.graphics.newImage("assets/enemy1.png")
  sprite_enemy_2 = love.graphics.newImage("assets/enemy2.png")
  sprite_bullets = love.graphics.newImage("assets/bullets_enemy_1.png")
end

-- =================================================================== --

function Enemies.update(dt)

  Enemies.move(dt)
  Enemies.shoot(dt)
  Enemies.move_shoots(dt)
  Enemies.create_from_pattern(dt)

end

-- =================================================================== --

function Enemies.draw()

  Enemies.draw_enemies()
  Enemies.draw_bullets()

end

-- =================================================================== --

function Enemies.draw_enemies()
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

-- =================================================================== --

function Enemies.draw_bullets()
  for j,b in pairs(Enemies.tab_bullets) do

    love.graphics.draw(sprite_bullets, b.x, b.y)
    if DEBUG_GAME == true then
      love.graphics.rectangle("line", b.x, b.y, 32, 32)
    end
  end
end

-- =================================================================== --

-- déplace les énnemies
local pattern_2_direction = 0
local pattern_3_direction = 1
function Enemies.move(dt)

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

    -- suppression des énnemies hors écran
    if e.y > love.graphics.getHeight() then
      table.remove(Enemies.list, i)
    end

  end

end

-- =================================================================== --

-- créer les vagues d'ennemies à partir d'un pattern
local indice_vague = 1
local delta_time = Enemies.pattern[1].period
local timer_vague = 0
function Enemies.create_from_pattern(dt)
  -- apparition des ennemies
  timer_vague = timer_vague + dt
  if timer_vague >= delta_time then

    local nb_enemies = Enemies.pattern[indice_vague].number
    local type_enemies = Enemies.pattern[indice_vague].type
    local pv_enemies = Enemies.pattern[indice_vague].pv
    local pattern_move = Enemies.pattern[indice_vague].pattern_move
    local type_fire = Enemies.pattern[indice_vague].fire
    local points = Enemies.pattern[indice_vague].points
    -- calcul écart des énemies
    local nb_ecarts = nb_enemies + 1
    local ecart_pixel = (love.graphics.getWidth() - (nb_enemies * 64)) / nb_ecarts

    -- creation des enemies
    for i = 1, nb_enemies do

      table.insert(Enemies.list, {

        x = ecart_pixel * i + (i -1) * 64,
        y = -64,
        speed = Enemies.speed,
        pv = pv_enemies,
        type = type_enemies,
        pattern_move = pattern_move,
        type_fire = type_fire,
        points = points
      })

    end

    indice_vague = indice_vague + 1
    timer_vague = 0
    if indice_vague > #Enemies.pattern then
      indice_vague = 1
    end
    delta_time = Enemies.pattern[indice_vague].period

  end
end

-- =================================================================== --

-- déplace les tirs énnemies
function Enemies.move_shoots(dt)
  -- DEPLACEMENT DES BULLETS
  for j,b in pairs(Enemies.tab_bullets) do

    -- si la bullet sort de l'écran
    if b.y > love.graphics.getHeight() then
      table.remove(Enemies.tab_bullets, j)
    end

    b.y = b.y + b.speed * dt
  end
end

-- =================================================================== --

-- Ajoute les tirs énnemies dans tab_bullets
local timerShooter = 0
function Enemies.shoot(dt)
  timerShooter = timerShooter + dt
  if timerShooter >= Enemies.shoot_interval then
    for i, e in pairs(Enemies.list) do

      if e.type_fire ~= 0 then
        table.insert(Enemies.tab_bullets, {

          x = e.x + 16,
          y = e.y,
          speed = Enemies.shoot_speed
    
        })

      end
    end
    timerShooter = 0
  end
end

return Enemies