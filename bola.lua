 
bola = {
  
  
lord = function()
--BOLA  
  sprite = love.graphics.newImage("assets/images/ball.png");
  x = 3550;--x/2
  y = 900;--y/2
  speed = 500;
  stop = true;
  
  cont = 1;
  
  bolaSpr = 0;
  
   quadsBall = {};
  maxQuadsBall = 7;
    

  for i=1,maxQuadsBall do
    if (i == 1) then
      quadsBall[i] = love.graphics.newQuad(0, 0, 64,64, sprite:getDimensions() )
    elseif(i == 2) then
      quadsBall[i] = love.graphics.newQuad(64, 0, 64,64, sprite:getDimensions() )
    elseif(i == 3) then
      quadsBall[i] = love.graphics.newQuad(0, 64, 64,64, sprite:getDimensions() )
    elseif(i == 4) then
      quadsBall[i] = love.graphics.newQuad(64, 64, 64,64, sprite:getDimensions() )
    elseif(i == 5) then
      quadsBall[i] = love.graphics.newQuad(0, 128, 64,64, sprite:getDimensions() )
    elseif(i == 6) then
      quadsBall[i] = love.graphics.newQuad(64, 128, 64,64, sprite:getDimensions() )
    else
      quadsBall[i] = love.graphics.newQuad(0, 192, 64,64, sprite:getDimensions() )
   end
     
  end
  
  --CONFIGURAÇÃO DA CAMERA
  --[[window = {}
  window.width = 5500--2100 -- com essa variavel definir o limite de movimentação da camera eixo x
  window.height = 1500-- com essa variavel definir o limite de movimentação da camera eixo y
  camera:setBounds(-900,-900, window.width,window.height)--[[player.x,player.y)--]]--window.width, window.height)--limitar movimentação da câmera
   camera:scale(3)--]]
end;

update = function(dt)
  --BOLA COMANDOS

    if love.keyboard.isDown('f') then
				x = x+speed*dt
        stop = false
  end
  
  if love.keyboard.isDown('s') then
				x = x-speed*dt
        stop = false
  end
  
  if love.keyboard.isDown('d') then
				y = y+speed*dt
        stop = false
  end
  
  if love.keyboard.isDown('e') then
				y = y-speed*dt
        stop = false
  end

  
  if cont<=maxQuadsBall then
    bolaSpr = quadsBall[cont]
    cont = cont+1
  else
    cont = 1
  end
  
  --camera:setPosition(ball.x/1.5,ball.y/1.5)--posição da camera x,y
end;


draw = function()
  
  --camera:set()--desenha camera com os padrões especificados pela função
  
     -- WRITE BOLA
  if stop == true then
    love.graphics.draw(sprite,quadsBall[1],x,y,0.4,0.4)
  else
    love.graphics.draw(sprite,bolaSpr,x,y,0.4, 0.4)
    stop=true
  end
  
  --camera:unset()--retona padrão da camera 
  
end;



};