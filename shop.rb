class Shop
  state_machine :initial => :anonymous do
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
  