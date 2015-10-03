  
-- DEFINE QUAL JOGADOR ESTAMOS UTILIZANDO (VALORES PERMITIDOS DE 1 A 11 SENDO 11 O GOLEIRO)
currentPlayer     = {}
currentPlayer._P1 = 11
currentPlayer._P2 = 12

-- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS INFORMAÇÕES DE CADA JOGADOR
player = {}

-- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS SPRITES DE CADA JOGADOR
sprite = {}

-- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR 'QUADS' DE CADA JOGADOR
quads = {}
  
-- VAMOS DEFINIR COMO SENDO O OBJETO QUE IRÁ GUARDAR AS AÇÕES DE CADA JOGADOR
action            = {}
action['kick']    = {}
action['pass']    = {}
action['halter']  = {}
action['cart']    = {}

-- VAMOS DEFINIR COMO SENDO O ARRAY QUE GUARDA OS BOTÕES DE CADA AÇÃO
button            = {}
button['kick']    = 'a'
button['pass']    = 's'
button['halter']  = 'w'
button['cart']    = 'd'

j    = {}
j[1] = 'up'
j[2] = 'right'
j[3] = 'down'
j[4] = 'left'
j[5] = 's'
j[6] = 'w'
j[7] = 'a'
j[8] = 'd'

--quadMovie = function(self)

for x=1,22 do
  
  player[x] = {}
  
  -- CONTROLLER (P1 OR P2)
  
  if x<=11 then
    player[x].controller = 'P1'
  else
    player[x].controller = 'P2'
  end
  
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
  
  
  player[x].nome = "player" .. x
  player[x].num = x


  -- ### START KICK ### --
  action['kick'][x] = {}

  -- DEFAULT QUAD
  action['kick'][x].quad = 1

  -- MAX QUAD
  action['kick'][x].maxQuad = 4
  -- ### END KICK ### --


  -- ### START PASS ### --
  action['pass'][x] = {}

  -- DEFAULT QUAD
  action['pass'][x].quad = 1

  -- MAX QUAD
  action['pass'][x].maxQuad = 3
  -- ### END PASS ### --


  -- ### START HALTER ### --
  action['halter'][x] = {}

  -- DEFAULT QUAD
  action['halter'][x].quad = 1

  -- MAX QUAD
  action['halter'][x].maxQuad = 3
  -- ### END HALTER ### --


  -- ### START CART ### --
  action['cart'][x] = {}

  -- DEFAULT QUAD
  action['cart'][x].quad = 1

  -- MAX QUAD
  action['cart'][x].maxQuad = 3
  -- ### END CART ### --


  -- ### START SPRITE SHEET ### --
  sprite[x]        = {}
  
  if x<=11 then
    sprite[x].player = love.graphics.newImage('assets/images/player1.png')
  else
    sprite[x].player = love.graphics.newImage('assets/images/player2.png')
  end
  
  sprite[x].x      = 100
  sprite[x].y      = 100
  sprite[x].px     = 0
  sprite[x].py     = 0
  -- ### END SPRITE SHEET ### --


  -- START QUADS

  -- RUN
  quads[x]           = {}
  quads[x]['left']   = {}
  quads[x]['right']  = {}
  quads[x]['up']     = {}
  quads[x]['down']   = {}

  -- KICK
  quads[x][button['kick']]          = {}
  quads[x][button['kick']]['left']  = {}
  quads[x][button['kick']]['right'] = {}
  quads[x][button['kick']]['up']    = {}
  quads[x][button['kick']]['down']  = {}

  -- PASS
  quads[x][button['pass']]          = {}
  quads[x][button['pass']]['left']  = {}
  quads[x][button['pass']]['right'] = {}
  quads[x][button['pass']]['up']    = {}
  quads[x][button['pass']]['down']  = {}

  -- HALTER
  quads[x][button['halter']]          = {}
  quads[x][button['halter']]['left']  = {}
  quads[x][button['halter']]['right'] = {}
  quads[x][button['halter']]['up']    = {}
  quads[x][button['halter']]['down']  = {}

  -- CART
  quads[x][button['cart']]          = {}
  quads[x][button['cart']]['left']  = {}
  quads[x][button['cart']]['right'] = {}
  quads[x][button['cart']]['up']    = {}
  quads[x][button['cart']]['down']  = {}

  -- END QUADS

  -- RUN
  for i=1,player[x].maxQuad do

    quads[x]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, 0, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 2, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 3, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

  end


  -- KICK
  for i=1,action['kick'][x].maxQuad do

    quads[x][button['kick']]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 4, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['kick']]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 5, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['kick']]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 6, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['kick']]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 7, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

  end


  -- PASS
  for i=1,action['pass'][x].maxQuad do

    quads[x][button['pass']]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 8, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['pass']]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 9, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['pass']]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 10, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['pass']]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 7, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

  end


  -- HALTER
  for i=1,action['halter'][x].maxQuad do

    quads[x][button['halter']]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 12, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['halter']]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 13, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['halter']]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 14, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['halter']]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 15, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

  end


  -- CART
  for i=1,action['cart'][x].maxQuad do

    quads[x][button['cart']]['left'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 16, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['cart']]['right'][i] = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 17, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['cart']]['up'][i]    = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 14, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )
    quads[x][button['cart']]['down'][i]  = love.graphics.newQuad( (i-1) * sprite[x].x, sprite[x].y * 19, sprite[x].x, sprite[x].y, sprite[x].player:getDimensions() )

  end

end -- FOR PLAYER
  
  -- TIME 01
  
  -- GOLEIRO
  sprite[1].px = 750
  sprite[1].py = 850

  -- LATERAL DIREITO
  sprite[2].px = 2500
  sprite[2].py = 1800

  -- ZAGUEIRO DIREITO
  sprite[3].px = 1900
  sprite[3].py = 1200

  -- ZAQUEIRO ESQUERDO
  sprite[4].px = 2000
  sprite[4].py = 400

  -- LATERAL ESQUERDO
  sprite[5].px = 2500
  sprite[5].py = 100

  -- VOLANTE DIREITO
  sprite[6].px = 2500
  sprite[6].py = 600

  -- VOLANTE ESQUERDO
  sprite[7].px = 2650
  sprite[7].py = 1000

  -- MEIA DIREITO
  sprite[8].px = 3300
  sprite[8].py = 1350

  -- MEIA ESQUERDO
  sprite[9].px = 3300
  sprite[9].py = 350

  -- ATACANTE DIREITO
  sprite[10].px = 3500
  sprite[10].py = 810
  player[10].direction = 'up'

  -- ATACANTE ESQUERDO
  sprite[11].px = 3500
  sprite[11].py = 750
  player[11].direction = 'down'
  

  -- TIME 02 
  
  -- GOLEIRO
  sprite[12].px = 7000
  sprite[12].py = 750

  -- LATERAL DIREITO
  sprite[13].px = 5000
  sprite[13].py = 350

  -- ZAGUEIRO DIREITO
  sprite[14].px = 6000
  sprite[14].py = 400

  -- ZAQUEIRO ESQUERDO
  sprite[15].px = 6000
  sprite[15].py = 1200

  -- LATERAL ESQUERDO
  sprite[16].px = 2500
  sprite[16].py = 1200

  -- VOLANTE DIREITO
  sprite[17].px = 5000
  sprite[17].py = 1000

  -- VOLANTE ESQUERDO
  sprite[18].px = 5000
  sprite[18].py = 600

  -- MEIA DIREITO
  sprite[19].px = 4000
  sprite[19].py = 350

  -- MEIA ESQUERDO
  sprite[20].px = 4000
  sprite[20].py = 1350

  -- ATACANTE DIREITO
  sprite[21].px = 3800
  sprite[21].py = 750
  player[21].direction = 'up'

  -- ATACANTE ESQUERDO
  sprite[22].px = 3800
  sprite[22].py = 810
  player[22].direction = 'down'