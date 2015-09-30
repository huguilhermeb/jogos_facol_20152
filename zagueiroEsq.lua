require 'sprite'

zagueiroEsq = {
  -- DEFAULTS
  iterationDirection = 1; -- ITERATION START
  iterationAction = 1; -- DEFAULT INDEX
	direction = "right"; -- DEFAULT DIRECTION
  
  -- GLOBAL
  idle = true;  -- PLAYER PARADO?
  action = false; -- PLAYER EXECUTANDO ALGUMA AÇÃO?
  
	timer = 0.1; -- ms
  speed = 0.2; -- SPEED INITIAL
  
  timeout = 0;
  sqm = 2; -- DEFAULT SQM LENGHT
  
  --posição inicial
  px = 2000;--1900;--x/2
  py = 400;--1200;--y/2
  
  nome="jogador";
  funcao = "zagueiroEsq";
  parado = "true";
  
  --[['right'
  'left'
  'down'--]]
  
  -- variaveis para receber dados da colisão
  actualX, actualY, cols, len = 0;
  
  lord = function(self)
    sprite:quadMovie(self)
  end;
  
  update = function(self,dt)
    
    --[[if love.keyboard.isDown('up') then
				self.py = self.py-self.sqm
			end--]]
   -- love.graphics.print('desenha kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', self.px, self.py)
  -- KICK
  if self.action == true then
    
    self.timer=self.timer+dt
    
    if self.iterationAction>sprite.maxAction then
      
      self.action = false
      self.iterationAction = 1
      self.iterationDirection = 1
      
    else
      
      if self.timer>0.15 then
        
        self.timer = 0.1
        self.iterationAction = self.iterationAction + 1
      
      end
      
    end -- timer>0.5
  
  -- DIRECTION
	elseif self.idle == false then
    
		self.timer = self.timer+dt
    
    self.timeout=self.timeout+dt
    if self.timeout>1.2 then
      self.speed = 0.17
      self.sqm = 15
    end
    
		if self.timer > self.speed then
      
			self.timer=0.1
			self.iterationDirection=self.iterationDirection+1      
      
			if love.keyboard.isDown('right') then 
				self.px = self.px+self.sqm
        self.parado = "false"
			end
      
			if love.keyboard.isDown('left') then
				self.px = self.px-self.sqm
        self.parado = "false"
			end
      
			if love.keyboard.isDown('down') then
				self.py = self.py+self.sqm
        self.parado = "false"
			end
      
			if love.keyboard.isDown('up') then
				self.py = self.py-self.sqm
        self.parado = "false"
			end
      
      --self.parado = "true"
      
			if (self.iterationDirection>sprite.maxDirection and self.direction~='up') or (self.iterationDirection>(sprite.maxDirection+1) and self.direction=='up') then
				self.iterationDirection = 2
			end
      
		end -- timer>0.2
    
	end -- idle == false
  
  world:update(self,self.px,self.py,120,160)
  
  self.actualX, self.actualY, self.cols, self.len = world:check(self, self.px, self.py)--,colisaoJogador)
  --self.px, self.py = self.actualX, self.actualY
  
  
  if self.len == 0 then
  ---self.x, self.y = actualX, actualY
  world:move(self, self.px, self.py)
end


  for i=1,self.len do
    local other = self.cols[i].type
    if other == "touch" then
        --ball.x=ball.x+(atacanteDir.px+120)
        --ball.y=ball.y+(atacanteDir.py+160)
        --manterpPosseBola(atacanteDir,dt)
        --moveBola(atacanteDir,dt)
    end
  end
  
  end;
  

  
  draw = function(self)
    --love.graphics.print('desenha kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', self.px, self.py)
    if self.action == true and self.iterationAction <= sprite.maxAction then
        love.graphics.draw(sprite.player,quads['a'][self.direction][self.iterationAction], self.px, self.py)
    elseif self.direction == 'left' or self.direction == 'right' or self.direction == 'up' or self.direction == 'down' then 
        love.graphics.draw(sprite.player,quads[self.direction][self.iterationDirection],self.px, self.py)
    end
  end;
  
  eventPress = function(self,key)
      -- has quad?
  if quads[key] then  
    if ( key == 'a' ) then
      if quads[key][self.direction] then
        self.idle = true
        self.action = true
      end -- quads[key][direction]
    else
     self.direction = key
     self.idle = false 
    end -- if key 
    end -- has quad?
  end;
  
  
  eventLeass = function(self,key)
    if quads[key] and self.direction == key then  
    self.idle = true
		self.iterationDirection = 1
    self.speed = 0.2
    self.timeout = 0
    end -- quads[key] and direction == key
  end;
  
  colisaoJogador = function(self,other)
    if     other.nome == "jogador"   then return "touch"
    end
  end

  
};