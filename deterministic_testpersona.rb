class DeterministicTestPersona
  
  def initialize statemachine
    @statemachine = statemachine
    @transitions_tried = []
  end
  
  def browse
    puts "Verifying starts state #{@statemachine.state}"
    @statemachine.verify
    
    until tried_everything
      puts "I'm in state #{@statemachine.state}"
      
      event = first_untried_event
      
      puts "I will perform event #{event}"
      
      @statemachine.fire_state_event event
      @statemachine.verify
    end
    
    puts "Tried everything from this state #{@end_state}"
  end
  
  private
  
    def tried_everything
      @statemachine.state_events.each do |event|
        state_event_id = @statemachine.state + "--" + event.to_s
        return false unless @transitions_tried.include? state_event_id
      end
      
      return true
    end
    
    def first_untried_event
      @statemachine.state_events.each do |event|
        state_event_id = @statemachine.state + "--" + event.to_s
        unless @transitions_tried.include? state_event_id
          @transitions_tried << state_event_id
          return event
        end
      end
      
      return nil
    end
  
end