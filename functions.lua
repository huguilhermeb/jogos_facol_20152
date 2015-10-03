function love.joystickpressed(joystick, b)
  
  --love.window.showMessageBox('Botão', 'button: ' .. b, "error")
  
  --[[inputtype, inputindex, hatdirection = joystick:getGamepadMapping( button )  
  love.window.showMessageBox('Joystick precionado', 'button: ' .. button .. ' - inputtype: ' .. inputtype .. ' - inputindex: ' .. inputindex .. ' - hatdirection: ' .. hatdirection, "error")--]]
  
  -- has quad?
  if quads[currentPlayer._P2][j[b]] then

    -- KICK
    if b == 7 then

      if quads[currentPlayer._P2][j[b]][player[currentPlayer._P2].direction] then

        player[currentPlayer._P2].idle    = true
        player[currentPlayer._P2].action  = 'kick'

      end

    -- PASS
    elseif b == 5 then

      if quads[currentPlayer._P2][j[b]][player[currentPlayer._P2].direction] then

        player[currentPlayer._P2].idle    = true
        player[currentPlayer._P2].action  = 'pass'

      end

    -- HALTER
    elseif b == 6 then

      if quads[currentPlayer._P2][j[b]][player[currentPlayer._P2].direction] then

        player[currentPlayer._P2].idle    = true
        player[currentPlayer._P2].action  = 'halter'

      end

    -- CART
    elseif b == 8 then

      if quads[currentPlayer._P2][j[b]][player[currentPlayer._P2].direction] then

        player[currentPlayer._P2].idle    = true
        player[currentPlayer._P2].action  = 'cart'

      end

    -- RUN
    else

      player[currentPlayer._P2].direction = j[b]
      player[currentPlayer._P2].idle      = false

    end -- if key

  end -- has quad?
  
end

function love.joystickreleased(joystick, b)
  
  if quads[currentPlayer._P2][j[b]] and player[currentPlayer._P2].direction == j[b] then

    player[currentPlayer._P2].idle    = true
    player[currentPlayer._P2].quad    = 1
    player[currentPlayer._P2].speed   = 0.2
    player[currentPlayer._P2].timeout = 0

  end
  
end



-- EVENT ON PRESS
function love.keypressed(key)

  -- has quad?
  if quads[currentPlayer._P1][key] then

    -- KICK
    if key == button['kick'] then

      if quads[currentPlayer._P1][key][player[currentPlayer._P1].direction] then

        player[currentPlayer._P1].idle    = true
        player[currentPlayer._P1].action  = 'kick'

      end -- quads[currentPlayer._P1][key][direction]

    -- PASS
    elseif key == button['pass'] then

      if quads[currentPlayer._P1][key][player[currentPlayer._P1].direction] then

        player[currentPlayer._P1].idle    = true
        player[currentPlayer._P1].action  = 'pass'

      end -- quads[currentPlayer._P1][key][direction]

    -- HALTER
    elseif key == button['halter'] then

      if quads[currentPlayer._P1][key][player[currentPlayer._P1].direction] then

        player[currentPlayer._P1].idle    = true
        player[currentPlayer._P1].action  = 'halter'

      end -- quads[currentPlayer._P1][key][direction]

    -- CART
    elseif key == button['cart'] then

      if quads[currentPlayer._P1][key][player[currentPlayer._P1].direction] then

        player[currentPlayer._P1].idle    = true
        player[currentPlayer._P1].action  = 'cart'

      end -- quads[currentPlayer._P1][key][direction]

    -- RUN
    else

      player[currentPlayer._P1].direction = key
      player[currentPlayer._P1].idle      = false

    end -- if key

  end -- has quad?

end

-- EVENT ON LEASS
function love.keyreleased(key)

  if quads[currentPlayer._P1][key] and player[currentPlayer._P1].direction == key then

    player[currentPlayer._P1].idle    = true
    player[currentPlayer._P1].quad    = 1
    player[currentPlayer._P1].speed   = 0.2
    player[currentPlayer._P1].timeout = 0

  end -- quads[currentPlayer._P1][key] and player[currentPlayer._P1].direction == key

end

colisaoBola = function(ball,other)
    
  for x=1,22 do
    if other.nome == "player" .. x then
      return "touch",other.num
    end
  end

end

colisaoJogador = function(player,other)
   if other.nome == "bola" then
    return "touch",player.num
  end
end


--[[roubaBola = function(dt)
  manterPosseBola(dt)
end--]]


manterPosseBola = function(dt,id)
    
  if player[id].controller == 'P1' then
    currentPlayer._P1 = id
  else
    currentPlayer._P2 = id
  end
    
  if player[id].direction == "up" then
    
      ball.x = sprite[id].px + 50
      ball.y = sprite[id].py + 50--100
              
  elseif player[id].direction == "right" then
    
      ball.x = sprite[id].px + 80--100
      ball.y = sprite[id].py + 80--100
  
  elseif player[id].direction == "down" then
    
      ball.x = sprite[id].px + 50--100
      ball.y = sprite[id].py + 80--100
  
  else
    
      ball.x = sprite[id].px
      ball.y = sprite[id].py + 80--100
      
  end
  
  -- KEYBOARD  
  if player[id].controller == 'P1' then
    
    if player[id].direction == "up" and  love.keyboard.isDown('up') then     
        ball.x = sprite[id].px + 50
        ball.y = sprite[id].py + 50--100
        moveBola(dt)        
    end
     
    if player[id].direction == "right" and  love.keyboard.isDown('right') then      
        ball.x = sprite[id].px + 80--100
        ball.y = sprite[id].py + 80--100
        moveBola(dt)        
    end
    
    if player[id].direction == "left" and  love.keyboard.isDown('left') then       
        ball.y = sprite[id].py + 80--100
        moveBola(dt)    
    end
    
    if player[id].direction == "down" and  love.keyboard.isDown('down') then      
        ball.x = sprite[id].px + 50
        ball.y = sprite[id].py + 90--100
        moveBola(dt)    
    end
  
  -- JOYSTICK 
  else
    
    if player[id].direction == "up" and  joystick:isDown(1) then     
        ball.x = sprite[id].px + 50
        ball.y = sprite[id].py + 50--100
        moveBola(dt)        
    end
     
    if player[id].direction == "right" and  joystick:isDown(2) then      
        ball.x = sprite[id].px + 80--100
        ball.y = sprite[id].py + 80--100
        moveBola(dt)        
    end
    
    if player[id].direction == "left" and  joystick:isDown(4) then       
        ball.y = sprite[id].py + 80--100
        moveBola(dt)    
    end
    
    if player[id].direction == "down" and  joystick:isDown(3) then      
        ball.x = sprite[id].px + 50
        ball.y = sprite[id].py + 90--100
        moveBola(dt)    
    end
    
  end
  
end


moveBola = function(self,dt)
  
  if ball.count <= ball.maxQuad then
    
    bola        = quadsBall[ball.count]
    ball.count  = ball.count+1
  
  else
    
    ball.count = 1
  end  
  
end