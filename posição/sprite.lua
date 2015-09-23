  
sprite = {
  -- DEFAULTS
  --[[iterationDirection = 1; -- ITERATION START
  iterationAction = 1; -- DEFAULT INDEX
	direction = "right"; -- DEFAULT DIRECTION--]]
  
  -- MAX
  maxDirection = 7; -- NUM. QUADS
  maxAction = 4; -- NUM. QUADS
  
  player = love.graphics.newImage("assets/images/player.png");
  x = 120;
  y = 175;
  
quadMovie = function(self)
  
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
  for i=1,self.maxDirection do
    
		quads['left'][i]  = love.graphics.newQuad( (i-1) * self.x, 0, self.x, self.y, self.player:getDimensions() )
		quads['right'][i] = love.graphics.newQuad( (i-1) * self.x, self.y, self.x, self.y, self.player:getDimensions() )
    quads['up'][i]    = love.graphics.newQuad( (i-1) * self.x, self.y * 2, self.x, self.y, self.player:getDimensions() )
    quads['down'][i]  = love.graphics.newQuad( (i-1) * self.x, self.y * 3, self.x, self.y, self.player:getDimensions() )
    
	end  
  quads['up'][self.maxDirection+1] = love.graphics.newQuad( 7*self.x, self.y*2, self.x, self.y, self.player:getDimensions() )
  
  -- KICK
  for i=1,self.maxAction do
    
		quads['a']['left'][i]  = love.graphics.newQuad( (i-1)*self.x, self.y*4, self.x, self.y, self.player:getDimensions() )
    quads['a']['right'][i] = love.graphics.newQuad( (i-1)*self.x, self.y*5, self.x, self.y, self.player:getDimensions() )
    
	end
  
  end;
  
  };