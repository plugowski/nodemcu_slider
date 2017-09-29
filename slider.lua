-- Slider Object

-- slider wie:
-- # jaka ma dlugosc toru dla wozka
-- # jaka jest pozycja wozka w danej chwili, nawet pomimo recznego ustawienia
-- # jaki bedzie kierunek jazdy

-- slider potrafi:
-- # zrezetowac ustawienie wozka do pozycji "0"
-- # zlecić przesuniecie wozka do danej pozycji w okreslonym czasie (wyliczyc predkosc dla Motora)
-- # zwalidowac czy mozliwe jest wykonanie zadanego zlecenia (dlugosc toru)

function Slider(length, dolly)
  
  -- reset dolly position
  local reset = function()
    dolly.gotoStart()
  end
  
  -- check current position of dolly, after manual setup
  local calibrate = function()
    -- first move dolly to position "0"...
    position = dolly.gotoStart()
    -- ...and then go back to initial position
    dolly.move(position)
  end
  
  -- validate possible postion if it is in scope
  local validate = function(position)

    if position < 0 or position > (length * 1) then
      return false
    end
    
    return true
  end
  
  -- move dolly from current position by distance in direction
  local moveDolly = function(distance, direction)
    
    local direction = direction or 'L'
    local currentDollyPosition = dolly.getPosition()
    local endPosition
    
    if direction == 'R' then 
      endposition = currentDollyPosition - distance
    else
      endposition = currentDollyPosition + distance
    end
    
    if validate(endposition) == true then
      dolly.move(distance, direction)
    end
    
  end
  
  return {
    reset = reset,
    calibrate = calibrate,
    moveDolly = moveDolly
  }

end