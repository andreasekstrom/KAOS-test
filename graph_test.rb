#!/usr/bin/env ruby

#Add current directory to load path
$: << File.expand_path(File.dirname(__FILE__)) unless $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'state_machine'
require 'shop'


shop = Shop.new
StateMachine::Machine.draw("Shop", {})
