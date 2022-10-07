
local Player = {}

Player.x = 400
Player.y = 500
Player.w = 64
Player.h = 64

-- bullets configuration
Player.tab_bullets = {}
Player.interval_shoot = 0.15 --0.5 secondes
Player.speed_shoot = 1500
Player.sprite_bullet_w = 32
Player.sprite_bullet_h = 32

--assets
local sprite_player 
local sprite_bullet_1
local sound_shoot_1



---------------------------------------------------

function Player.load()
  sprite_player = love.graphics.newImage("assets/vessel.png")
  sprite_bullet_1 = love.graphics.newImage("assets/bullets1.png")
  sound_shoot_1 = love.audio.newSource("assets/sounds/shoot1.wav", "static")
end

---------------------------------------------------

function Player.shoot()
  sound_shoot_1:stop()
  sound_shoot_1:play()
  table.insert(Player.tab_bullets, {

      x = Player.x+Player.sprite_bullet_w/2,
      y = Player.y,
      speed = Player.speed_shoot

    })

end


---------------------------------------------------

function Player.draw()

  


  for i,b in pairs(Player.tab_bullets) do

    love.graphics.draw(sprite_bullet_1, b.x, b.y)
    if DEBUG_GAME == true then
      love.graphics.rectangle("line", b.x, b.y, 32, 32)
    end
  end
  love.graphics.draw(sprite_player, Player.x, Player.y)

end

---------------------------------------------------


local timerShooter = 0
function Player.update(dt)

  -- debug
  
  print(Player.tab_bullets[1])

  -- bullets
  for i,b in pairs(Player.tab_bullets) do

    -- si la bullet sort de l'écran
    if b.y < -64 then
      table.remove(Player.tab_bullets, i)
    end

    b.y = b.y - b.speed * dt
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