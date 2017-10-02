function Controller(pin)
  
  buttons = {
    BTN_UP,
    BTN_DWN,
    BTN_LFT,
    BTN_RGT,
    BTN_SEL
  }
--  adc.read(0) -- read analog signal
  
  local readButton = function()
    
    while true
    do
      io.write('button: ')
      button = io.read()
      return button
    end
    
  end
    
  return {
    readButton = readButton
  }
end