require 'vendors/functions'

-- todo: for tests only
require 'vendors/gpio'
gpio = gpio()

-- load required objects
require 'slider/slider'
require 'slider/dolly'
require 'slider/motor'

require 'menu/menu'
require 'controller/controller'

local pins = {
  motor_sleep = 0,
  motor_step = 1,
  motor_stop = 2,
  motor_dir = 3,
  controller_navigate = 4
}

local motor = Motor(pins, 200, 10.2) 
local dolly = Dolly(motor)
local slider = Slider(1200, dolly)
local controller = Controller(pins.controller_navigate)
local menu = Menu(controller, slider);

while (true)
do
  menu.build()
  menu.navigate()
end