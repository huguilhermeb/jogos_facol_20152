function love.load()
  
  -- GLOBAL
  idle      = true  -- PLAYER PARADO?
  action    = false -- PLAYER EXECUTANDO ALGUMA AÇÃO?
  
	timer     = 0.1 -- ms
  speed     = 0.2 -- SPEED INITIAL
  
  timeout   = 0
  sqm       = 5 -- DEFAULT SQM LENGHT
	  -- DEFAULTS
  iterationDirection  = 1 -- ITERATION START
  iterationAction     = 1 -- DEFAULT INDEX
	direction           = "right" -- DEFAULT DIRECTION
  
  -- MAX
  maxDirection  = 7 -- NUM. QUADS
  maxAction     = 4 -- NUM. QUADS
  
  -- BACKGROUND
  background = love.graphics.newImage("assets/images/background.jpg")
  
  -- SPRITE SHEET
  sprite        = {}
  sprite.player = love.graphics.newImage("assets/images/player.png")
  sprite.x      = 120
  sprite.y      = 175
  
  -- QUADS
  quads           = {}
  quads['left']   = {}
  quads['right']  = {}
  quads['up']     = {}
  quads['down']   = {}
  
  quads['a']          = {}
  quads['a']['left']  = {}
  quads['a']['right'] = {}
  
  -- DIRECTION
  for i=1,maxDirection do
    
		quads['left'][i]  = love.graphics.newQuad( (i-1) * sprite.x, 0, sprite.x, sprite.y, sprite.player:getDimensions() )
		quads['right'][i] = love.graphics.newQuad( (i-1) * sprite.x, sprite.y, sprite.x, sprite.y, sprite.player:getDimensions() )
    quads['up'][i]    = love.graphics.newQuad( (i-1) * sprite.x, sprite.y * 2, sprite.x, sprite.y, sprite.player:getDimensions() )
    quads['down'][i]  = love.graphics.newQuad( (i-1) * sprite.x, sprite.y * 3, sprite.x, sprite.y, sprite.player:getDimensions() )
    
	end  
  quads['up'][maxDirection+1] = love.graphics.newQuad( 7*sprite.x, sprite.y*2, sprite.x, sprite.y, sprite.player:getDimensions() )
  
  -- KICK
  for i=1,maxAction do
    
		quads['a']['left'][i]  = love.graphics.newQuad( (i-1)*sprite.x, sprite.y*4, sprite.x, sprite.y, sprite.player:getDimensions() )
    quads['a']['right'][i] = love.graphics.newQuad( (i-1)*sprite.x, sprite.y*5, sprite.x, sprite.y, sprite.player:getDimensions() )
    
	end
  
end -- LOAD

function love.draw()
  
  -- WRITE BACKGROUND
  love.graphics.draw(background)
  
  if action == true and iterationAction <= maxAction then
  
    love.graphics.draw(sprite.player, quads['a'][direction][iterationAction], sprite.x, sprite.y)
  
  elseif direction == 'left' or direction == 'right' or direction == 'up' or direction == 'down' then 
  
		love.graphics.draw(sprite.player, quads[direction][iterationDirection], sprite.x, sprite.y)
	
  end
	  
end -- DRAW

function love.update(dt)
  
  -- KICK
  if action == true then
    
    timer=timer+dt
    
    if iterationAction>maxAction then
      
      action              = false
      iterationAction     = 1
      iterationDirection  = 1
      
    else
      
      if timer>0.15 then
        
        timer           = 0.1
        iterationAction = iterationAction + 1
      
      end
      
    end -- timer>0.5
  
  -- DIRECTION
	elseif idle == false then
    
		timer=timer+dt
    
    timeout=timeout+dt
    if timeout>1.2 then
      speed=0.17
      sqm=15
    end
    
		if timer>speed then
      
			timer=0.1
			iterationDirection=iterationDirection+1      
      
			if love.keyboard.isDown('right') then 
				sprite.x = sprite.x+sqm
			end
      
			if love.keyboard.isDown('left') then
				sprite.x = sprite.x-sqm
			end
      
			if love.keyboard.isDown('down') then
				sprite.y = sprite.y+sqm
			end
      
			if love.keyboard.isDown('up') then
				sprite.y = sprite.y-sqm
			end
      
			if (iterationDirection>maxDirection and direction~='up') or (iterationDirection>(maxDirection+1) and direction=='up') then
				iterationDirection = 2
			end
      
		end -- timer>0.2
    
	end -- idle == false
  
end -- UPDATE

-- EVENT ON PRESS
function love.keypressed(key)
	
  -- has quad?
  if quads[key] then
		
    if ( key == 'a' ) then
      
      if quads[key][direction] then
      
        idle    = true
        action  = true
      
      end -- quads[key][direction]
      
    else
      
      direction = key
      idle      = false
      
    end -- if key
    
	
  end -- has quad?

end

-- EVENT ON LEASS
function love.keyreleased(key)
  
	if quads[key] and direction == key then
		
    idle                = true
		iterationDirection  = 1
    speed               = 0.2
    timeout             = 0
  
  end -- quads[key] and direction == key
  
end

