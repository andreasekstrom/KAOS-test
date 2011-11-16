require 'capybara'
require 'capybara/dsl'
require "selenium-webdriver"

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:4567/kaos/'
Capybara.run_server = false

# This seems to be the default...
#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :firefox)
#end

class Shop
  
  def initialize
    Capybara.visit("http://www.google.com/")
    super()
  end
  
  state_machine :initial => :anonymous do
    
    after_transition :on => :add_to_cart do
      Capybara.visit("http://www.apple.com/")
    end
    
    event :add_to_cart do
      transition :anonymous  => :anonymous
    end
    
    event :go_to_checkout do
      transition :anonymous => :in_checkout
    end
    
    event :login do
      transition :in_checkout => :in_checkout_logged_in
    end
    
    event :logout do
      transition :in_checkout_logged_in => :anonymous
    end
  end
end
  