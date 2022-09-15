require 'pry'
require_relative 'task'
require_relative 'process'

p = Stepper::Process.new('data/simple_example_process.yaml')
p.run
