#!/usr/bin/env ruby

#Add current directory to load path
$: << File.expand_path(File.dirname(__FILE__)) unless $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'state_machine'
require 'irb'
require 'irb/completion'
require 'shop'
require 'random_testpersona'
require 'deterministic_testpersona'

shop = Shop.new

if ARGV.include? '--irb'
  SHOP = shop
  ARGV.clear
  IRB.start
elsif ARGV.include? '--draw'
  StateMachine::Machine.draw("Shop", {})
else
  #test_persona = DeterministicTestPersona.new(shop)
  test_persona = RandomTestPersona.new(shop, 10, "in_checkout_logged_in")
  test_persona.browse
end
