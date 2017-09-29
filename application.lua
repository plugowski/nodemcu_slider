require 'functions'

-- load required objects
require 'slider'
require 'dolly'
require 'motor'

-- todo: for tests only
require '../vendors/gpio'
gpio = gpio()

-- parse ini config file
local ini = require 'vendors/ini'
config = ini.parse_file('config.ini')

local motor = Motor(config.motor.resolution, config.motor.pulley_diameter) 
local dolly = Dolly(motor)
local slider = Slider(config.slider.length, dolly)
