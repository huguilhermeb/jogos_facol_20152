-- DECLARING THE BALL 
ball          = {}
ball.sprite   = love.graphics.newImage("assets/images/ball.png")
ball.x        = 4970--3550 -- x/2
ball.y        = 2785--900 -- y/2
ball.speed    = 90
ball.stop     = true
ball.nome     = "bola"
ball.emPosse  = false
ball.height   = 64
ball.width    = 64
ball.count    = 1
ball.maxQuad  = 7

-- QUADS BALL
quadsBall = {}
  
-- START CREATE QUAD BALL
for i=1,ball.maxQuad do
      
  if (i == 1) then      
      quadsBall[i] = love.graphics.newQuad( 0, 0, ball.width, ball.height, ball.sprite:getDimensions() )
  elseif (i == 2) then      
      quadsBall[i] = love.graphics.newQuad( 64, 0, ball.width, ball.height, ball.sprite:getDimensions() )
  elseif (i == 3) then      
      quadsBall[i] = love.graphics.newQuad( 0, 64, ball.width, ball.height, ball.sprite:getDimensions() )
  elseif (i == 4) then
      quadsBall[i] = love.graphics.newQuad( 64, 64, ball.width, ball.height, ball.sprite:getDimensions() )
  elseif (i == 5) then      
      quadsBall[i] = love.graphics.newQuad( 0, 128, ball.width, ball.height, ball.sprite:getDimensions() )
  elseif (i == 6) then      
      quadsBall[i] = love.graphics.newQuad( 64, 128, ball.width, ball.height, ball.sprite:getDimensions() )
  else      
      quadsBall[i] = love.graphics.newQuad( 0, 192, ball.width, ball.height, ball.sprite:getDimensions() )
  end
   
end
-- END CREATE QUAD BALL

-- UPDATE
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


--[[if ball.count<=ball.maxQuad then
  bola = quadsBall[cont]
  ball.count = ball.count+1
else
  ball.count = 1
end--]]