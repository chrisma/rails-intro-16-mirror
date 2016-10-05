module TddHelpers
  
  def init_message
    @tdd_message = ''
    @tdd_message_then = ''
  end
  
  def Given(txt)
    @tdd_message += 'Given ' + txt + "\n"
  end
  
  def When(txt)
    @tdd_message += 'When ' + txt + "\n"
  end
  
  def And(txt)
    @tdd_message += 'And ' + txt + "\n"
  end
  
  def Then(txt)
    @tdd_message_then = 'Then ' + txt
  end
  
  def get_bdd_message
    @tdd_message + @tdd_message_then
  end
  
  def test_run
    yield
  rescue  RSpec::Expectations::ExpectationNotMetError => e
    fail get_bdd_message + e.message
  rescue Exception => e
    fail get_bdd_message + "\nBut got " + e.class.name + ": " + e.message
  end
end

RSpec.configure do |config|
  config.include TddHelpers
end