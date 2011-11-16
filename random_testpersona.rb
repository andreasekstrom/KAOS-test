class RandomTestPersona
  
  def initialize statemachine, max_transitions, end_state
    @statemachine = statemachine
    @max_transitions = max_transitions
    @end_state = end_state
  end
  
  def browse
    @max_transitions.times do |iteration|
      puts "I'm in state #{@statemachine.state}"
      
      if @statemachine.state == @end_state
        puts "Reached end state #{@end_state} after #{iteration} transitions!"
        return
      end
       
      events = @statemachine.state_events
      
      event = events[rand(events.size)]
      
      puts "I will perform event #{event}"
      
      @statemachine.fire_state_event event
      @statemachine.verify
    end

    puts "Tried to reach end state #{@end_state} but failed after #{@max_transitions} transitions"
  end
  
end