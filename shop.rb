require 'capybara'
require 'capybara/dsl'
require "selenium-webdriver"

Capybara.default_driver = :selenium
Capybara.app_host = 'http://localhost:4567'
Capybara.run_server = false

# This seems to be the default...
#Capybara.register_driver :selenium do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :firefox)
#end

class Shop
  
  def initialize
    Capybara.visit("/")
    super()
  end
  
  state_machine :initial => :anonymous do
    
    # The transitions defining the state machine
    
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
    
    # Actions for transitions
    
    after_transition :on => :add_to_cart do
      Capybara.click_link("Add to cart")
    end
    
    after_transition :on => :go_to_checkout do
      Capybara.click_link("Go to checkout")
    end
    
    after_transition :on => :login do
      Capybara.click_link("Login")
      Capybara.fill_in("username", :with => "John Doe")
      Capybara.fill_in("password", :with => "secret")
      Capybara.click_button("Login")
    end
    
    after_transition :on => :logout do
      Capybara.click_link("Logout")
    end
    
    # Verifications of states

    state :anonymous do
      def verify
        unless Capybara.page.has_content? "Login"
          abort "Failed to verify that you are in the state #{state}"
        end
      end
    end

    state :in_checkout do
      def verify
        unless Capybara.page.has_content? "Checkout"
          abort "Failed to verify that you are in the state #{state}"
        end
      end
    end

    state :in_checkout_logged_in do
      def verify
        unless Capybara.page.has_content? "Welcome John Doe" and Capybara.page.has_content? "Checkout"
          abort "Failed to verify that you are in the state #{state}"
        end
      end
    end
    
  end
end
  