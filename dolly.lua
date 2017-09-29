-- Dolly Object

-- dolly knows:
-- # its own position (distance) from "0"

-- dolly can:
-- # move in specified direction by specified distance using motor

function Dolly(motor)
  
  local position = 0
  
  local getPosition = function()
    return position
  end
  
  -- move dolly to position "0"
  local gotoStart = function()
    
    local distance = 0
 
    while (gpio.read(config.pins.stop) ~= gpio.HIGH) do
      distance = distance + motor.step('R')
    end
    
    position = 0
    
    return distance 
  end
  
  local move = function(distance, direction)

    local moved = motor.move(distance, direction)
    
    if direction == 'R' then
      position = position - moved
    else
      position = position + moved
    end
    
    -- return distance
    return moved
  end

  return {
    getPosition = getPosition,
    gotoStart = gotoStart,
    move = move
  }
end