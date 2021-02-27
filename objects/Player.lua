
local Player = {}

Player.x = 400
Player.y = 500
Player.w = 64
Player.h = 64

Player.interval_shoot = 0.1 --0.5 secondes

--assets
local sprite_player 
local sprite_bullet_1
local sound_shoot_1


local tab_bullets = {}
local debug = true

---------------------------------------------------

function Player.load()
  sprite_player = love.graphics.newImage("assets/vessel.png")
  sprite_bullet_1 = love.graphics.newImage("assets/bullets.png")
  sound_shoot_1 = love.audio.newSource("assets/sounds/shoot1.wav", "static")
end

---------------------------------------------------

function Player.shoot()
  sound_shoot_1:play()
  table.insert(tab_bullets, {

      x = Player.x+16,
      y = Player.y,
      speed = 20

    })

end


---------------------------------------------------

function Player.draw()

  love.graphics.draw(sprite_player, Player.x, Player.y)


  for i,b in pairs(tab_bullets) do

    love.graphics.draw(sprite_bullet_1, b.x, b.y)

  end


end

---------------------------------------------------

local nb_frame = 0
local timerFps = 0
local timerShooter = 0
function Player.update(dt)


  ------------- FPS
  if debug == true then
    nb_frame = nb_frame + 1
    timerFps = timerFps + dt
    if timerFps >= 1 then
      timerFps = 0
      print("fps:" .. tostring(nb_frame))
      nb_frame = 0
    end
  end
  ------------- FIN FPS

  -- bullets
  for i,b in pairs(tab_bullets) do

    -- si la bullet sort de l'écran
    if b.y < 100 then
      table.remove(tab_bullets, i)
    end

    b.y = b.y - b.speed
  end


  -- click gauche - shoot
  if love.mouse.isDown(1) then
    timerShooter = timerShooter + dt
    if timerShooter >= Player.interval_shoot then
      Player.shoot()
      timerShooter = 0
    end

  end

end

---------------------------------------------------

function Player.mousemoved(x, y, dx, dy, istouch)
  Player.x = x - Player.w/2
  Player.y = y - Player.h/2
end

---------------------------------------------------

function Player.mousepressed(x, y, button, istouch)

end

return Player

---------------------------------------------------