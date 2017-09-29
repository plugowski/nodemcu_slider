-- gpio wrapper for tests
function gpio()
  
  local pinLevels = {}
  local pinModes = {}
  
  HIGH = 1
  LOW = 0
  OUTPUT = 'OUTPUT'
  OPENDRAIN = 'OPENDRAIN'
  INPUT = 'INPUT'
  INT = 'INT'
  
  local mode = function(pin, mode)
    pinModes[pin] = mmode
    print('mode', 'pin: ' .. pin, mode)
  end
  
  local read = function(pin)
    local value = pinLevels[pin] or 0
    
    -- to simulate pressing stop button
    if pin == config.pins.stop then
      math.randomseed(os.time())
      if math.floor(math.random(1, 100)) > 60 then
        value = 1
      end
    end
    
    print('read', 'pin: ' .. pin, 'value: ' .. value)
    return value
  end
  
  local write = function(pin, level)
    pinLevels[pin] = level
    print('write', 'pin: ' .. pin, 'level: ' .. level)
  end

  return {
    HIGH = HIGH,
    LOW = LOW,
    OUTPUT = OUTPUT,
    OPENDRAIN = OPENDRAIN,
    INPUT = INPUT,
    INT = INT,
    mode = mode,
    read = read,
    write = write
  }
end