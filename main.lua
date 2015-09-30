bump = require 'bump'
require 'util'
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
  
  world = bump.newWorld()
  
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
  ball.speed = 90
  ball.stop = true
  ball.nome = "bola"
  quadsBall = {}
  cont = 1
  auxX = 0
  auxY = 0
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
  
  
  world:add(ball,0,0,10,10)
  
  world:add(goleiro,0,0,120,160)
  world:add(zagueiroEsq,0,0,120,160)
  world:add(zagueiroDir,0,0,120,160)
  world:add(lateralDir,0,0,120,160)
  world:add(lateralEsq,0,0,120,160)
  world:add(primeiroVol,0,0,120,160)
  world:add(segundoVol,0,0,120,160)
  world:add(meioCampoDir,0,0,120,160)
  world:add(meioCampoEsq,0,0,120,160)
  world:add(atacanteEsq,0,0,120,160)
  world:add(atacanteDir,0,0,120,160)
  
  
  actualXB, actualYB, colsB, lenB = 0-- variaveis para receber parametros da colisão
  
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
  if ball.stop == true and cont == 1 then
    love.graphics.draw(ball.sprite,quadsBall[1],ball.x,ball.y,0.4,0.4)
  else
    love.graphics.draw(ball.sprite,bola,ball.x,ball.y,0.4, 0.4)
    ball.stop=true
    --atacanteDir.parado="true"
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
  
  --[[world:update(atacanteDir,atacanteDir.px,atacanteDir.py,120,160)--120,160--]]
  world:update(ball,ball.x,ball.y,10,10)
  
  actualXB, actualYB, colsB, lenB = world:check(ball, ball.x, ball.y,colisaoBola)
  ball.x, ball.y = actualXB, actualYB
  
  
  if lenB == 0 then
  ball.x, ball.y = actualXB, actualYB
  world:move(ball, ball.x, ball.y)
  end

  
  --goleiro:update(dt);
  --zagueiroEsq:update(dt);
  --zagueiroDir:update(dt);
  --lateralEsq:update(dt);
  --lateralDir:update(dt);
  --primeiroVol:update(dt);
  --segundoVol:update(dt);
  --meioCampoEsq:update(dt);
  --meioCampoDir:update(dt);
  atacanteEsq:update(dt);
  atacanteDir:update(dt);
  
  
  for i=1,lenB do
    local otherType = colsB[i].type
    if otherType == "touch" then
        --ball.x=ball.x+(atacanteDir.px+120)
        --ball.y=ball.y+(atacanteDir.py+160)
        manterpPosseBola(atacanteDir,dt)
        --moveBola(atacanteDir,dt)
    end
  end
  
    --[[local actualXSA, actualYSA, colsSA, lenSA = world:move(atacanteDir,atacanteDir.px,atacanteDir.py)--]]
  --atacanteDir.px, atacanteDir.py = atacanteDir.actualX, atacanteDir.actualY
  --atacanteEsq.px, atacanteEsq.py = atacanteEsq.actualX, atacanteEsq.actualY
  
  
  --BOLA COMANDOS

    --[[if love.keyboard.isDown('f') then
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
  end--]]

  
  --[[if cont<=maxQuadsBall then
    bola = quadsBall[cont]
    cont = cont+1
  else
    cont = 1
  end--]]
  
  camera:setPosition(ball.x/1.5,ball.y/1.5)--posição da camera x,y

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

colisaoBola = function(ball,other)
  if     other.nome == "jogador"   then return "touch"
  end
end

manterpPosseBola = function(self,dt)
   
   if (self.parado == "true") then
      
      if self.direction == "up" then
          ball.x = self.px+60
          ball.y = self.py+100
          --moveBola(dt)
      elseif self.direction == "right" then
          ball.x = self.px+110
          ball.y = self.py+135
          --moveBola(dt)
      else
          ball.x = self.px
          ball.y = self.py+135
      end
    end
    
   if(self.direction == "up" and  love.keyboard.isDown('up')) then
      --self.parado = "true"
      ball.x = self.px+60
      ball.y = self.py+100
      moveBola(dt)
  end
   
   if(self.direction == "right" and  love.keyboard.isDown('right')) then
     --self.parado = "true"
      ball.x = self.px+110
      ball.y = self.py+135
      moveBola(dt)
  end
  
  if(self.direction == "left" and  love.keyboard.isDown('left')) then
     --self.parado = "true"
      ball.y = self.py+135
      moveBola(dt)
  end
  
  if(self.direction == "down" and  love.keyboard.isDown('down')) then
    --self.parado = "true"
     ball.x = self.px+60
     ball.y = self.py+145
     moveBola(dt)
  end
  
  self.parado = "true"
end


moveBola = function(self,dt)
 
  --manterpPosseBola(self) 
 
  if cont<=maxQuadsBall then
    bola = quadsBall[cont]
    cont = cont+1
  else
    cont = 1
  end
  
  
  end
