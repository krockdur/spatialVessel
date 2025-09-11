
local Player = {}

Player.x = 400
Player.y = 500
Player.w = 64
Player.h = 64
Player.a = 0            -- Angle du joueur (rad)
Player.target_a = 0     -- Angle des tirs (rad): vers le curseur de la souris
Player.speed = 5  
Player.score = 0

-- bullets configuration
Player.weapon_type = 1
Player.tab_bullets = {}
Player.interval_shoot = 0.1 --0.5 secondes
Player.speed_shoot = 2500
Player.sprite_bullet_w = 32
Player.sprite_bullet_h = 32

--assets
local sprite_player 
local sprite_bullet_1
local sound_shoot_1


--
local touch_left = false
local touch_right = false
local touch_up = false
local touch_down = false


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

      --x = Player.x+Player.sprite_bullet_w/2,
      x = Player.x,
      y = Player.y,
      speed = Player.speed_shoot,
      a = Player.target_a

    })

end


---------------------------------------------------

function Player.draw()

  for i,b in pairs(Player.tab_bullets) do

    love.graphics.draw(sprite_bullet_1, b.x, b.y, b.a, 1, 1, sprite_bullet_1:getWidth()/2, sprite_bullet_1:getHeight()/2)
    if DEBUG_GAME == true then
      love.graphics.rectangle("line", b.x, b.y, 32, 32)
    end
  end
  love.graphics.draw(sprite_player, Player.x, Player.y, Player.a, 1, 1, sprite_player:getWidth()/2, sprite_player:getHeight()/2)


  --
  -- print debug
  --love.graphics.print("getWidth: "..tostring(love.graphics.getWidth()), 10, 30)
  --love.graphics.print("getHeight: "..tostring(love.graphics.getHeight()), 10, 50)

  --love.graphics.print("x: "..tostring(Player.x), 10, 70)
  --love.graphics.print("y: "..tostring(Player.y), 10, 90)
end

---------------------------------------------------


local timerShooter = 0
function Player.update(dt)

  -- debug
  
  -- print(Player.tab_bullets[1])

  -- bullets
  for i,b in pairs(Player.tab_bullets) do

    -- si la bullet sort de l'écran
    if b.y < 0 or b.y > love.graphics.getHeight() or b.x < 0 or b.x > love.graphics.getWidth() then
      table.remove(Player.tab_bullets, i)
    end

    -- b.y = b.y - b.speed * dt
    b.x = b.x+b.speed * math.sin(b.a) * dt
    b.y = b.y-b.speed * math.cos(b.a) * dt

  end


  -- Acquisition déplacement zqsd
  local direction_x = 0
  local direction_y = 0
  if love.keyboard.isDown("z") or love.keyboard.isDown("w") or touch_up then --UP
    direction_y = -1
  end
  if love.keyboard.isDown("q") or love.keyboard.isDown("a") or touch_left then -- LEFT
    direction_x = -1
  end
  if love.keyboard.isDown("s") or touch_down then -- DOWN
    direction_y = 1
  end
  if love.keyboard.isDown("d") or touch_right then -- RIGHT
    direction_x = 1
  end

  if touch_left and touch_up then
    direction_y = -1
    direction_x = -1
  end

  if touch_up and touch_right then
    direction_y = -1
    direction_x = 1
  end

  if touch_right and touch_down then
    direction_y = 1
    direction_x = 1
  end

  if touch_down and touch_left then
    direction_y = 1
    direction_x = -1
  end


  -- déplacement
  
  Player.x = (Player.x + (Player.speed * direction_x  ))  % love.graphics.getWidth()
  Player.y = (Player.y + (Player.speed * direction_y ))   % love.graphics.getHeight()

  -- orientation des tirs (vers souris)
  local dx = Player.x - love.mouse.getX()
  local dy = Player.y - love.mouse.getY()

  if Player.y > love.mouse.getY() then
    Player.target_a = -math.atan(dx/dy)
  end
  if Player.y < love.mouse.getY() then
    Player.target_a = math.pi-math.atan(dx/dy)
  end

  -- Orientation du vaisseau
  if direction_x == 1 then
    if direction_y == 0 then
      Player.a = math.pi / 2
    end
    if direction_y == 1 then
      Player.a = 3 * math.pi / 4
    end
    if direction_y == -1 then
      Player.a = math.pi / 4
    end
  end

  if direction_x == -1 then
    if direction_y == 0 then
      Player.a = -math.pi / 2
    end
    if direction_y == 1 then
      Player.a = - 3 * math.pi / 4
    end
    if direction_y == -1 then
      Player.a = - math.pi / 4
    end
  end

  if direction_x == 0 then
    if direction_y == 0 then
      Player.a = 0
    end
    if direction_y == 1 then
      Player.a = math.pi
    end
    if direction_y == -1 then
      Player.a = 0
    end
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

function Player.keypressed(key, scancode, isrepeat)


end


---------------------------------------------------

function Player.mousemoved(x, y, dx, dy, istouch)
  --Player.x = x - Player.w/2
  --Player.y = y - Player.h/2
end

---------------------------------------------------

function Player.mousepressed(x, y, button, istouch)

end

---------------------------------------------------
function Player.touchmoved( id, x, y, dx, dy, pressure )

  if dx < 0 then
    touch_left = true
    touch_right = false
    touch_up = false
    touch_down = false
  end
  if dx > 0 then
    touch_left = false
    touch_right = true
    touch_up = false
    touch_down = false
  end
  if dy < 0 then
    touch_left = false
    touch_right = false
    touch_up = true
    touch_down = false
  end
  if dy > 0 then
    touch_left = false
    touch_right = false
    touch_up = false
    touch_down = true
  end

  if dy < 0 and dx < 0 then
    touch_left = true
    touch_right = false
    touch_up = true
    touch_down = false
  end

  if dy < 0 and dx > 0 then
    touch_left = false
    touch_right = true
    touch_up = true
    touch_down = false
  end

  if dy > 0 and dx < 0 then
    touch_left = true
    touch_right = false
    touch_up = false
    touch_down = true
  end

  if dy > 0 and dx > 0 then
    touch_left = false
    touch_right = true
    touch_up = false
    touch_down = true
  end
  
end

---------------------------------------------------

function Player.touchreleased( id, x, y, dx, dy, pressure )
    touch_left = false
    touch_right = false
    touch_up = false
    touch_down = false
end

---------------------------------------------------
return Player

---------------------------------------------------