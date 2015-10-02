-- BUMP
bump = require 'bump'

-- JOYSTICK
joysticks = love.joystick.getJoysticks()
joystick  = joysticks[1]

-- OTHERS REQUIRES
require 'util'
require 'camera'
require 'player'
require 'ball'
require 'functions'

function love.load()

  -- DECLARING THE NEW WORLD
  world = bump.newWorld()

  -- ADD PLAYERS TO THE WORLD
  for x=1,11 do
      world:add(sprite[x],sprite[x].px,sprite[x].py,100,100)
  end

  -- ADD THE BALL TO THE WORLD
  world:add( ball,0,0,10,10 )

  -- BACKGROUND
  background = love.graphics.newImage("assets/images/background.png")

  -- BACKGROUND COORDINATES (posiçao inicial da bola)
  x,y = background:getDimensions()

  -- variaveis para receber parametros da colisão
  actualXB, actualYB, colsB, lenB = 0

  -- CONFIGURAÇÃO DA CAMERA
  window        = {}
  window.width  = 5500--2100 -- com essa variavel definir o limite de movimentação da camera eixo x
  window.height = 1500-- com essa variavel definir o limite de movimentação da camera eixo y
  camera:setBounds(-900,-900, window.width,window.height)--[[player.x,player.y)--]]--window.width, window.height)--limitar movimentação da câmera
  camera:scale(3)

end -- LOAD

function love.draw()

  -- desenha camera com os padrões especificados pela função
  camera:set()

  -- WRITE BACKGROUND
  love.graphics.draw( background,0,0,0,2,2,0,0,0,0 )

   -- WRITE BOLA
  if ball.stop == true and ball.count == 1 then

    love.graphics.draw( ball.sprite,quadsBall[1],ball.x,ball.y,0.4,0.4 )

  else

    -- PRA QUE SERVE A VARIÁVEL BOLA ABAIXO?
    love.graphics.draw( ball.sprite, bola, ball.x, ball.y, 0.4, 0.4 )
    ball.stop=true

  end

  -- START P1
  if player[currentPlayer._P1].action ~= false then

    -- if action['kick'][currentPlayer._P1].quad <= action['kick'][currentPlayer._P1].maxQuad
    if action[player[currentPlayer._P1].action][currentPlayer._P1].quad <= action[player[currentPlayer._P1].action][currentPlayer._P1].maxQuad then
      love.graphics.draw(sprite[currentPlayer._P1].player, quads[currentPlayer._P1][button[player[currentPlayer._P1].action]][player[currentPlayer._P1].direction][action[player[currentPlayer._P1].action][currentPlayer._P1].quad], sprite[currentPlayer._P1].px, sprite[currentPlayer._P1].py)
    end

  elseif player[currentPlayer._P1].quad <= player[currentPlayer._P1].maxQuad and (player[currentPlayer._P1].direction == 'left' or player[currentPlayer._P1].direction == 'right' or player[currentPlayer._P1].direction == 'up' or player[currentPlayer._P1].direction == 'down') then

    love.graphics.draw(sprite[currentPlayer._P1].player, quads[currentPlayer._P1][player[currentPlayer._P1].direction][player[currentPlayer._P1].quad], sprite[currentPlayer._P1].px, sprite[currentPlayer._P1].py)
    --fim do desenha sprite

  end
  -- END P1

  -- START P2
  if player[currentPlayer._P2].action ~= false then

    -- if action['kick'][currentPlayer._P2].quad <= action['kick'][currentPlayer._P2].maxQuad
    if action[player[currentPlayer._P2].action][currentPlayer._P2].quad <= action[player[currentPlayer._P2].action][currentPlayer._P2].maxQuad then
      love.graphics.draw(sprite[currentPlayer._P2].player, quads[currentPlayer._P2][button[player[currentPlayer._P2].action]][player[currentPlayer._P2].direction][action[player[currentPlayer._P2].action][currentPlayer._P2].quad], sprite[currentPlayer._P2].px, sprite[currentPlayer._P2].py)
    end

  elseif player[currentPlayer._P2].quad <= player[currentPlayer._P2].maxQuad and (player[currentPlayer._P2].direction == 'left' or player[currentPlayer._P2].direction == 'right' or player[currentPlayer._P2].direction == 'up' or player[currentPlayer._P2].direction == 'down') then

    love.graphics.draw(sprite[currentPlayer._P2].player, quads[currentPlayer._P2][player[currentPlayer._P2].direction][player[currentPlayer._P2].quad], sprite[currentPlayer._P2].px, sprite[currentPlayer._P2].py)
    --fim do desenha sprite

  end
  -- END P2

  for x=1,11 do

    if currentPlayer._P1 ~= x and currentPlayer._P2 ~= x then

      love.graphics.draw(sprite[x].player, quads[x][player[x].direction][player[x].quad], sprite[x].px, sprite[x].py)

    end

  end

  camera:unset()--retona padrão da camera
end -- DRAW

function love.update(dt)

  --[[world:update(atacanteDir,atacanteDir.px,atacanteDir.py,120,160)--120,160--]]
  world:update(ball,ball.x,ball.y,10,10)

  actualXB, actualYB, colsB, lenB = world:check(ball, ball.x, ball.y,colisaoBola)
  ball.x, ball.y = actualXB, actualYB


  if lenB == 0 then

    ball.x, ball.y = actualXB, actualYB
    world:move(ball, ball.x, ball.y)

  end

  -- START P1
  if player[currentPlayer._P1].action ~= false then

    player[currentPlayer._P1].timer = player[currentPlayer._P1].timer + dt

    if action[player[currentPlayer._P1].action][currentPlayer._P1].quad > action[player[currentPlayer._P1].action][currentPlayer._P1].maxQuad then

      player[currentPlayer._P1].quad                                    = 1
      action[player[currentPlayer._P1].action][currentPlayer._P1].quad  = 1
      player[currentPlayer._P1].action                                  = false

    else

      if player[currentPlayer._P1].timer > 0.15 then

        player[currentPlayer._P1].timer                                   = 0.1
        action[player[currentPlayer._P1].action][currentPlayer._P1].quad  = action[player[currentPlayer._P1].action][currentPlayer._P1].quad + 1

      end

    end -- player[currentPlayer._P1].action ~= false

  elseif player[currentPlayer._P1].idle == false then

    player[currentPlayer._P1].timer   = player[currentPlayer._P1].timer + dt
    player[currentPlayer._P1].timeout = player[currentPlayer._P1].timeout + dt

    if player[currentPlayer._P1].timeout > 1.2 then

      player[currentPlayer._P1].speed = 0.17
      player[currentPlayer._P1].sqm   = 15

    end

    if player[currentPlayer._P1].timer > player[currentPlayer._P1].speed then

      player[currentPlayer._P1].timer = 0.1
      player[currentPlayer._P1].quad  = player[currentPlayer._P1].quad + 1

      if love.keyboard.isDown('right') then
        sprite[currentPlayer._P1].px = sprite[currentPlayer._P1].px + player[currentPlayer._P1].sqm
      end

      if love.keyboard.isDown('left') then
        sprite[currentPlayer._P1].px = sprite[currentPlayer._P1].px - player[currentPlayer._P1].sqm
      end

      if love.keyboard.isDown('down') then
        sprite[currentPlayer._P1].py = sprite[currentPlayer._P1].py + player[currentPlayer._P1].sqm
      end

      if love.keyboard.isDown('up') then
        sprite[currentPlayer._P1].py = sprite[currentPlayer._P1].py - player[currentPlayer._P1].sqm
      end

      if player[currentPlayer._P1].quad > player[currentPlayer._P1].maxQuad then
        player[currentPlayer._P1].quad = 2
      end

    end -- player[currentPlayer._P1].timer > player[currentPlayer._P1].speed

  end -- player[currentPlayer._P1].idle == false
  -- END P1

  -- START P2
  if player[currentPlayer._P2].action ~= false then

    player[currentPlayer._P2].timer = player[currentPlayer._P2].timer + dt

    if action[player[currentPlayer._P2].action][currentPlayer._P2].quad > action[player[currentPlayer._P2].action][currentPlayer._P2].maxQuad then

      player[currentPlayer._P2].quad                                    = 1
      action[player[currentPlayer._P2].action][currentPlayer._P2].quad  = 1
      player[currentPlayer._P2].action                                  = false

    else

      if player[currentPlayer._P2].timer > 0.15 then

        player[currentPlayer._P2].timer                                   = 0.1
        action[player[currentPlayer._P2].action][currentPlayer._P2].quad  = action[player[currentPlayer._P2].action][currentPlayer._P2].quad + 1

      end

    end -- player[currentPlayer._P2].action ~= false

  elseif player[currentPlayer._P2].idle == false then

    player[currentPlayer._P2].timer   = player[currentPlayer._P2].timer + dt
    player[currentPlayer._P2].timeout = player[currentPlayer._P2].timeout + dt

    if player[currentPlayer._P2].timeout > 1.2 then

      player[currentPlayer._P2].speed = 0.17
      player[currentPlayer._P2].sqm   = 15

    end

    if player[currentPlayer._P2].timer > player[currentPlayer._P2].speed then

      player[currentPlayer._P2].timer = 0.1
      player[currentPlayer._P2].quad  = player[currentPlayer._P2].quad + 1

      if joystick:isDown(2) then
        sprite[currentPlayer._P2].px = sprite[currentPlayer._P2].px + player[currentPlayer._P2].sqm
      end

      if joystick:isDown(4) then
        sprite[currentPlayer._P2].px = sprite[currentPlayer._P2].px - player[currentPlayer._P2].sqm
      end

      if joystick:isDown(3) then
        sprite[currentPlayer._P2].py = sprite[currentPlayer._P2].py + player[currentPlayer._P2].sqm
      end

      if joystick:isDown(1) then
        sprite[currentPlayer._P2].py = sprite[currentPlayer._P2].py - player[currentPlayer._P2].sqm
      end

      if player[currentPlayer._P2].quad > player[currentPlayer._P2].maxQuad then
        player[currentPlayer._P2].quad = 2
      end

    end -- player[currentPlayer._P2].timer > player[currentPlayer._P2].speed

  end -- player[currentPlayer._P2].idle == false
  -- END P2

  for i=1,lenB do

    local otherType = colsB[i].type

    if otherType == "touch" then
        manterpPosseBola(dt)
    end
  end

  --[[local actualXSA, actualYSA, colsSA, lenSA = world:move(atacanteDir,atacanteDir.px,atacanteDir.py)--]]
  --atacanteDir.px, atacanteDir.py = atacanteDir.actualX, atacanteDir.actualY
  --atacanteEsq.px, atacanteEsq.py = atacanteEsq.actualX, atacanteEsq.actualY

  camera:setPosition( ball.x/1.5, ball.y/1.5 )--posição da camera x,y

end -- UPDATE
