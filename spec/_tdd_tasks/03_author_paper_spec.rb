require 'rails_helper'

describe "Paper", :type => :model do
  
  before(:each) do
    init_message
  end 

  it "should have and belong to many authors" do
    test_run do
      @paper = FactoryGirl.create :paper_tdd
      Given "a paper titled '#{@paper.title}'"
      
      Then "it should have an empty list of authors"
      expect(@paper.authors).to eq([])
    end
  end
end