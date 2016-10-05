require 'rails_helper'

describe "Author" do
  
  before(:each) do
    init_message
  end
  
  it "just works" do
    test_run do
      Given("a thing")
      And("another thing")

      When("I do the thing")
      And("the other thing")

      Then("it should just work")
      expect(1).to eq(2)
    end
  end
  
end