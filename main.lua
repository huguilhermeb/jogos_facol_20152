function love.load()
  
  -- WIDTH AND HEIGHT
  w, h = love.window.getDimensions()
  
  -- CENTER
  centerW = (w * 0.5) - 40
  centerH = (h * 0.5) - 70
  
  -- BACKGROUND (CAMPO)
  background = love.graphics.newImage("assets/images/background.jpg")

  -- DEFINE QUAL JOGADOR ESTAMOS UTILIZANDO (VALORES PERMITIDOS DE 1 A 11 SENDO 11 O GOLEIRO)
  currentPlayer = 1 

  -- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS INFORMAÇÕES DE CADA JOGADOR
  player = {}
  
  -- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS SPRITES DE CADA JOGADOR
  sprite = {}
  
  -- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR 'QUADS' DE CADA JOGADOR
  quads = {}
  
  -- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS AÇÕES DE CADA JOGADOR
  action          = {}
  action['kick']  = {}

  for x=1,1 do
    
    player[x] = {}

    -- PLAYER x ESTÁ PARADO
    player[x].idle = true

    -- PLAYER x NÃO ESTÁ EXECUTANDO NENHUMA AÇÃO
    player[x].action = false

    -- SPEED (VELOCIDADE DO JOGADOR x)
    player[x].speed = 0.2

    -- DEFAULT DIRECTION
    player[x].direction = 'right'

    -- DEFAULT QUAD
    player[x].quad = 1

    -- MAX QUAD
    player[x].maxQuad = 7

    -- CONSTANT
    -- USADO PARA O CALCULO DA VELOCIDADE
    -- ESTOU ATRIBUINDO AQUI CASO FUTURAMENTE SEJA NECESSÁRIO QUE CADA PLAYER TENHA UM "TIMER" DIFERENTE
    player[x].timer = 0.1
    player[x].timeout = 0

    -- CONSTANT
    -- USADO PARA O MOVIMENTO, INDICA QUANTOS "BLOCOS" O PLAYER DEVE ANDAR
    -- ESTOU ATRIBUINDO AQUI CASO FUTURAMENTE SEJA NECESSÁRIO QUE CADA PLAYER TENHA UM "TIMER" DIFERENTE
    player[x].sqm = 5


    -- ### START KICK ### --
    action['kick'][x] = {}

    -- DEFAULT QUAD
    action['kick'][x].quad = 1

    -- MAX QUAD
    action['kick'][x].maxQuad = 4
    -- ### END KICK ### --


    -- ### START SPRITE SHEET ### --
    sprite[x]        = {}
    sprite[x].player = love.graphics.newImage('assets/images/player' .. x .. '.png')
    sprite[x].x      = 75
    sprite[x].y      = 108
    sprite[x].px     = centerW
    sprite[x].py     = centerH
    -- ### END SPRITE SHEET ### --


    -- QUADS
    quads[x]           = {}
    quads[x]['left']   = {}
    quads[x]['right']  = {}
    quads[x]['up']     = {}
    quads[x]['down']   = {}

    quads[x]['a']          = {}
    quads[x]['a']['left']  = {}
    quads[x]['a']['right'] = {}


    -- DIRECTION
    for i=1,player[x].maxQuad do

      quads[x]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, 0, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
      quads[x]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
      quads[x]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 2, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
      quads[x]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 3, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

    end  
    quads[x]['up'][player[x].maxQuad+1] = love.graphics.newQuad( player[x].maxQuad * sprite[x].x, sprite[x].y * 2, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )


    -- KICK
    for i=1,action['kick'][x].maxQuad do

      quads[x]['a']['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 4, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
      quads[x]['a']['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 5, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

    end

  end -- FOR PLAYER

end -- LOAD

function love.draw()

  -- WRITE BACKGROUND
  love.graphics.draw(background)
  
  if player[currentPlayer].action ~= false then
    
    -- if action['kick'][currentPlayer].quad <= action['kick'][currentPlayer].maxQuad
    if action[player[currentPlayer].action][currentPlayer].quad <= action[player[currentPlayer].action][currentPlayer].maxQuad then
      love.graphics.draw(sprite[currentPlayer].player, quads[currentPlayer]['a'][player[currentPlayer].direction][action[player[currentPlayer].action][currentPlayer].quad], sprite[currentPlayer].px, sprite[currentPlayer].py)
    end
    
  elseif player[currentPlayer].quad <= player[currentPlayer].maxQuad and (player[currentPlayer].direction == 'left' or player[currentPlayer].direction == 'right' or player[currentPlayer].direction == 'up' or player[currentPlayer].direction == 'down') then
    
    love.graphics.draw(sprite[currentPlayer].player, quads[currentPlayer][player[currentPlayer].direction][player[currentPlayer].quad], sprite[currentPlayer].px, sprite[currentPlayer].py)
      
  end  

end -- DRAW

function love.update(dt)
  
  if player[currentPlayer].action ~= false then

    player[currentPlayer].timer = player[currentPlayer].timer + dt

    if action[player[currentPlayer].action][currentPlayer].quad > action[player[currentPlayer].action][currentPlayer].maxQuad then
      
      player[currentPlayer].quad                                = 1
      action[player[currentPlayer].action][currentPlayer].quad  = 1
      player[currentPlayer].action                              = false      

    else

      if player[currentPlayer].timer > 0.15 then

        player[currentPlayer].timer                               = 0.1
        action[player[currentPlayer].action][currentPlayer].quad  = action[player[currentPlayer].action][currentPlayer].quad + 1
                
      end

    end -- player[currentPlayer].action ~= false

  elseif player[currentPlayer].idle == false then

    player[currentPlayer].timer   = player[currentPlayer].timer + dt
    player[currentPlayer].timeout = player[currentPlayer].timeout + dt
    
    if player[currentPlayer].timeout > 1.2 then
      player[currentPlayer].speed = 0.17
      player[currentPlayer].sqm   = 15
    end

    if player[currentPlayer].timer > player[currentPlayer].speed then

      player[currentPlayer].timer = 0.1
      player[currentPlayer].quad  = player[currentPlayer].quad + 1      

      if love.keyboard.isDown('right') then 
        sprite[currentPlayer].px = sprite[currentPlayer].px + player[currentPlayer].sqm
      end

      if love.keyboard.isDown('left') then
        sprite[currentPlayer].px = sprite[currentPlayer].px - player[currentPlayer].sqm
      end

      if love.keyboard.isDown('down') then
        sprite[currentPlayer].py = sprite[currentPlayer].py + player[currentPlayer].sqm
      end

      if love.keyboard.isDown('up') then
        sprite[currentPlayer].py = sprite[currentPlayer].py - player[currentPlayer].sqm
      end

      if (player[currentPlayer].quad > player[currentPlayer].maxQuad and player[currentPlayer].direction ~= 'up') or (player[currentPlayer].quad > (player[currentPlayer].maxQuad + 1) and player[currentPlayer].direction == 'up') then
        player[currentPlayer].quad = 2
      end

    end -- player[currentPlayer].timer > player[currentPlayer].speed

  end -- player[currentPlayer].idle == false

end -- UPDATE

-- EVENT ON PRESS
function love.keypressed(key)

  -- has quad?
  if quads[currentPlayer][key] then

    if ( key == 'a' ) then

      if quads[currentPlayer][key][player[currentPlayer].direction] then

        player[currentPlayer].idle    = true
        player[currentPlayer].action  = 'kick'

      end -- quads[currentPlayer][key][direction]

    else

      player[currentPlayer].direction = key
      player[currentPlayer].idle      = false

    end -- if key

  end -- has quad?

end

-- EVENT ON LEASS
function love.keyreleased(key)

  if quads[currentPlayer][key] and player[currentPlayer].direction == key then

    player[currentPlayer].idle    = true
    player[currentPlayer].quad    = 1
    player[currentPlayer].speed   = 0.2
    player[currentPlayer].timeout = 0

  end -- quads[currentPlayer][key] and player[currentPlayer].direction == key

end

