module TddHelpers
  
  def init_message
    @tdd_given = []
    @tdd_when = []
    @tdd_then = nil
  end
  
  def Given(txt)
    @tdd_then = nil
    @tdd_given << txt
    @tdd_and = :Given
  end
  
  def When(txt)
    @tdd_then = nil
    @tdd_when << txt
    @tdd_and = :When
  end
  
  def Then(txt)
    @tdd_then = txt
    @tdd_and = :Then
  end
  
  def And(txt)
    self.send @tdd_and, txt
  end
  
  def get_bdd_message
    msg = ""
    @tdd_given.each_with_index do |t,n|
      msg += n == 0 ? "Given " : "And "
      msg += t
      msg += "  \n"
    end
    @tdd_when.each_with_index do |t,n|
      msg += n == 0 ? "When " : "And "
      msg += t
      msg += "  \n"
    end
    if @tdd_then
      msg += "Then " + @tdd_then + "  \n"
    end
    msg
  end
  
  def test_run
    yield
  rescue  RSpec::Expectations::ExpectationNotMetError => e
    msg = e.message.strip.capitalize
    fail get_bdd_message + "\n" + msg
  rescue Exception => e
    puts e.backtrace
    fail get_bdd_message + "\nGot " + e.class.name + ": " + e.message
  end
  
  def fill_author(first_name, last_name, homepage)
    fill_in "author_first_name", :with => first_name
    fill_in "author_last_name", :with => last_name
    fill_in "author_homepage", :with => homepage
  end
  
  def fill_paper(title, venue, year)
    fill_in "paper_title", :with => title
    fill_in "paper_venue", :with => venue
    fill_in "paper_year", :with => year
  end
  
  def submit_form()
    find('input[name="commit"]').click
  end
end

RSpec.configure do |config|
  config.include TddHelpers
end