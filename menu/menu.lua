-- Menu Object

-- Menu hierarchy

-- start / stop
-- -- progress information + stop action -> reset slider
-- reset
-- settings
-- -- set distance
-- -- -- XXXX mm (OK, return top)
-- -- set duration
-- -- -- 00h 00m 00s (OK, return top)
-- -- set start position
-- -- -- use arrows to move dolly (OK, return top)
-- -- set end position
-- -- -- use arrows to move dolly (OK, return top)
-- -- exit

function Menu(controller, slider)

  local _index = 0

  -- build current menu screen
  local build = function()
    
  end

  local save = function(text)
    local file = io.open('settings.txt', 'w')
--    io.output(file)
    if file ~= nil then
      file:write(text .. '\n')
      file:close()
--      io.write('someshit')
--      io.close(file)
    end
  end

  -- step into menu position
  local activate = function()
    
  end

  -- navigate through menu
  local navigate = function()
    
    local button = tonumber(controller.readButton())
    
    -- down button
    if button == 0x01 then
      _index = _index + 1
      print('down')
    -- up button
    elseif button == 0x05 then
      if _index > 0 then _index = _index -1 end
      print('up')
    -- select button
    elseif button == 0x03 then
      activate()
      print('select')
    -- left button
    elseif button == 0x02 then
      print('left')
    -- right button
    elseif button == 0x04 then
      print('right')
    end
  end



  return {
    build = build,
    navigate = navigate
  }

end