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
  
  --[[if other.nome == "jogador" then
    return "touch"
  end--]]
  
  return "touch"
  
end

manterpPosseBola = function(dt)
   
  if player[currentPlayer._P1].idle == "true" then
      
    if player[currentPlayer._P1].direction == "up" then
      
        ball.x = sprite[currentPlayer._P1].px + 60
        ball.y = sprite[currentPlayer._P1].py + 100
                
    elseif p.direction == "right" then
      
        ball.x = sprite[currentPlayer._P1].px + 110
        ball.y = sprite[currentPlayer._P1].py + 135
                
    else
      
        ball.x = sprite[currentPlayer._P1].px
        ball.y = sprite[currentPlayer._P1].py + 135
        
    end
    
  end
    
  if player[currentPlayer._P1].direction == "up" and  love.keyboard.isDown('up') then
     
      ball.x = sprite[currentPlayer._P1].px + 60
      ball.y = sprite[currentPlayer._P1].py + 100
      moveBola(dt)
      
  end
   
  if player[currentPlayer._P1].direction == "right" and  love.keyboard.isDown('right') then
    
      ball.x = sprite[currentPlayer._P1].px + 110
      ball.y = sprite[currentPlayer._P1].py + 135
      moveBola(dt)
      
  end
  
  if player[currentPlayer._P1].direction == "left" and  love.keyboard.isDown('left') then
     
      ball.y = sprite[currentPlayer._P1].py + 135
      moveBola(dt)
  
  end
  
  if player[currentPlayer._P1].direction == "down" and  love.keyboard.isDown('down') then
    
      ball.x = sprite[currentPlayer._P1].px + 60
      ball.y = sprite[currentPlayer._P1].py + 145
      moveBola(dt)
  
  end
  
  player[currentPlayer._P1].idle = "true"
  
end


moveBola = function(self,dt)
  
  if ball.count <= ball.maxQuad then
    
    bola        = quadsBall[ball.count]
    ball.count  = ball.count+1
  
  else
    
    ball.count = 1
  end  
  
end