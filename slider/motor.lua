-- Motor object 

-- motor knows:
-- # diameter of used pulley
-- # resolution (steps by rotation)
-- # distance by step

-- motor can:
-- # move by specified distance (how many steps should jump)
-- # move on specified direction
-- # todo: change step mode 1/2, 1/4, 1/8 i 1/16 for better precission

function Motor(pins, resolution, pulley)
  
  -- distance for one pulley rotate
  local rotate = 2 * 3.1415 * (pulley / 2)
  -- distance for one full step of motor
  local stepDistance = rotate / resolution
  -- driver status
  local sleepStatus = 0
  
  -- init gpio pins and make motor ready
  local init = function()
    gpio.mode(pins.motor_sleep, gpio.OUTPUT)
    gpio.mode(pins.motor_step, gpio.OUTPUT)
    gpio.mode(pins.motor_dir, gpio.OUTPUT)
    gpio.mode(pins.motor_stop, gpio.INPUT)
    
    gpio.write(pins.motor_sleep, gpio.LOW)
    gpio.write(pins.motor_step, gpio.LOW)
    gpio.write(pins.motor_dir, gpio.LOW)
  end
  
  local wakeup = function()
    gpio.write(pins.motor_sleep, gpio.LOW)
    sleepStatus = 0
  end
  
  local hibernate = function()
    gpio.write(pins.motor_sleep, gpio.HIGH)
    sleepStatus = 1
  end
  
  -- get motor hibernation status
  local isSleep = function()
    return sleepStatus
  end
  
  -- get limit switch status true for limit reached
  local limitSwitch = function()
    return gpio.read(pins.motor_stop) == gpio.HIGH
  end
  
  -- interval for stepper
  local getInterval = function(distance, time)
    
    if time == nil then return 0 end
    -- speed = mm / s
    local speed = distance / time
    -- stepper = steps / s
    local stepper = speed / stepDistance
    -- interval = s / step
    local interval = 1 / stepper
    
    return interval
  end
  
  -- move doly by one step in specified direction
  local step = function(direction)
    
    if direction == 'R' then
       gpio.write(pins.motor_dir, gpio.HIGH)
    end
    
     gpio.write(pins.motor_step, gpio.HIGH)
     gpio.write(pins.motor_step, gpio.LOW)
     gpio.write(pins.motor_dir, gpio.LOW)

    -- return the distance in mm
    return stepDistance;
  end
  
  -- move dolly by distance and direction L|R (left, right)
  local move = function(distance, direction, time)
    
    local dst = 0;
    local interval = getInterval(distance, time)

    while dst <= distance and limitSwitch() == false do
      dst = dst + step(direction)
      if time ~= nil then
        sleep(interval)
      end
    end
    
    return dst
  end
  
  init()
  
  -- public some local methods
  return {
    isSleep = isSleep,
    limitSwitch = limitSwitch,
    wakeup = wakeup,
    sleep = sleep,
    step = step,
    move = move
  }
end