require 'util'
bump = require 'bump'
require 'camera'
require 'goleiro'
require 'zagueiroEsq'
require 'zagueiroDir'
require 'lateralEsq'
require 'lateralDir'
require 'primeiroVol'
require 'segundoVol'
require 'meioCampoEsq'
require 'meioCampoDir'
require 'atacanteEsq'
require 'atacanteDir'

function love.load()
  
  goleiro:lord()
  zagueiroEsq:lord()
  zagueiroDir:lord()
  lateralEsq:lord()
  lateralDir:lord()
  primeiroVol:lord()
  segundoVol:lord()
  meioCampoEsq:lord()
  meioCampoDir:lord()
  atacanteEsq:lord()
  atacanteDir:lord()
  
  -- BACKGROUND
  background = love.graphics.newImage("assets/images/background3.png")
  x,y = background:getDimensions()--posiçao inicial da bola
 
   --BOLA
  ball = {}
  maxQuadsBall = 7
  ball.sprite = love.graphics.newImage("assets/images/ball.png")
  ball.x = 3550--x/2
  ball.y = 900--y/2
  ball.speed = 0
  ball.stop = true
  quadsBall = {}
  cont = 1
  for i=1,maxQuadsBall do
    if (i == 1) then
      quadsBall[i] = love.graphics.newQuad(0, 0, 64,64, ball.sprite:getDimensions() )
    elseif(i == 2) then
      quadsBall[i] = love.graphics.newQuad(64, 0, 64,64, ball.sprite:getDimensions() )
    elseif(i == 3) then
      quadsBall[i] = love.graphics.newQuad(0, 64, 64,64, ball.sprite:getDimensions() )
    elseif(i == 4) then
      quadsBall[i] = love.graphics.newQuad(64, 64, 64,64, ball.sprite:getDimensions() )
    elseif(i == 5) then
      quadsBall[i] = love.graphics.newQuad(0, 128, 64,64, ball.sprite:getDimensions() )
    elseif(i == 6) then
      quadsBall[i] = love.graphics.newQuad(64, 128, 64,64, ball.sprite:getDimensions() )
    else
      quadsBall[i] = love.graphics.newQuad(0, 192, 64,64, ball.sprite:getDimensions() )
   end
     
  end
  
  
  --CONFIGURAÇÃO DA CAMERA
  window = {}
  window.width = 5500--2100 -- com essa variavel definir o limite de movimentação da camera eixo x
  window.height = 1500-- com essa variavel definir o limite de movimentação da camera eixo y
  camera:setBounds(-900,-900, window.width,window.height)--[[player.x,player.y)--]]--window.width, window.height)--limitar movimentação da câmera
   camera:scale(3)
end -- LOAD

function love.draw()
   camera:set()--desenha camera com os padrões especificados pela função
  
  -- WRITE BACKGROUND
  love.graphics.draw(background,0,0,0,2,2,0,0,0,0)
	 
   -- WRITE BOLA
  if ball.stop == true then
    love.graphics.draw(ball.sprite,quadsBall[1],ball.x,ball.y,0.4,0.4)
  else
    love.graphics.draw(ball.sprite,bola,ball.x,ball.y,0.4, 0.4)
    ball.stop=true
  end
  
  goleiro:draw();
   zagueiroEsq:draw();
   zagueiroDir:draw();
   lateralEsq:draw();
   lateralDir:draw();
   primeiroVol:draw();
   segundoVol:draw();
   meioCampoEsq:draw();
   meioCampoDir:draw();
   atacanteEsq:draw();
   atacanteDir:draw();

   
    
  camera:unset()--retona padrão da camera
end -- DRAW

function love.update(dt)
  
  --goleiro:update(dt);
  --zagueiroEsq:update(dt);
  --zagueiroDir:update(dt);
  --lateralEsq:update(dt);
  --lateralDir:update(dt);
  --primeiroVol:update(dt);
  --segundoVol:update(dt);
  --meioCampoEsq:update(dt);
  --meioCampoDir:update(dt);
  --atacanteEsq:update(dt);
  atacanteDir:update(dt);
  
  --BOLA COMANDOS

    if love.keyboard.isDown('f') then
				ball.x = ball.x+50
        ball.stop = false
  end
  
  if love.keyboard.isDown('s') then
				ball.x = ball.x-50
        ball.stop = false
  end
  
  if love.keyboard.isDown('d') then
				ball.y = ball.y+50
        ball.stop = false
  end
  
  if love.keyboard.isDown('e') then
				ball.y = ball.y-50
        ball.stop = false
  end

  
  if cont<=maxQuadsBall then
    bola = quadsBall[cont]
    cont = cont+1
  else
    cont = 1
  end
  
  camera:setPosition(ball.x/1.7,ball.y/1.7)--posição da camera x,y

end -- UPDATE

-- EVENT ON PRESS
function love.keypressed(key)
  --goleiro:eventPress(key)
  --zagueiroEsq:eventPress(key)
  --zagueiroDir:eventPress(key)
  --lateralEsq:eventPress(key)
  --lateralDir:eventPress(key)
  --primeiroVol:eventPress(key)
  --segundoVol:eventPress(key)
  --meioCampoEsq:eventPress(key)
  --meioCampoDir:eventPress(key)
  --atacanteEsq:eventPress(key)
  atacanteDir:eventPress(key)
end

-- EVENT ON LEASS
function love.keyreleased(key)
  --goleiro:eventLeass(key)
  --zagueiroEsq:eventLeass(key)
  --zagueiroDir:eventLeass(key)
  --lateralEsq:eventLeass(key)
  --lateralDir:eventLeass(key)
  --primeiroVol:eventLeass(key)
  -- segundoVol:eventLeass(key)
  --meioCampoEsq:eventLeass(key)
  --meioCampoDir:eventLeass(key)
  --atacanteEsq:eventLeass(key)
  atacanteDir:eventLeass(key)
end