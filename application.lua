require 'vendors/functions'

-- todo: for tests only
require 'vendors/gpio'
gpio = gpio()

-- load required objects
require 'slider/slider'
require 'slider/dolly'
require 'slider/motor'

--require 'menu/menu'

-- parse ini config file
local ini = require 'vendors/ini'
config = ini.parse_file('config.ini')

local pins = {
  motor_sleep = 0,
  motor_step = 1,
  motor_stop = 2,
  motor_dir = 3
}

local motor = Motor(pins, config.motor.resolution, config.motor.pulley_diameter) 
local dolly = Dolly(motor)
local slider = Slider(tonumber(config.slider.length), dolly)

while (true)
do
--  local menu = Menu();
--  menu.init();
end