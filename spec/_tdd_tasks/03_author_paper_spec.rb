require 'rails_helper'

describe "Paper", :type => :model do
  
  before(:each) do
    init_message
  end 

  it "should have and belong to many authors" do
    test_run do
      @paper = FactoryGirl.create :paper_tdd
      Given "a paper"
      
      Then "it should have an empty list of authors"
      expect(@paper.authors).to eq([])
    end
  end
end

describe "Author", :type => :model do
  
  before(:each) do
    init_message
  end 

  it "should have and belong to many papers" do
    test_run do
      @alan = FactoryGirl.create :author_tdd
      Given "an author"
      
      Then "it should have an empty list of papers"
      expect(@alan.papers).to eq([])
    end
  end
end

describe "Paper page", :type => :feature do
  
  before(:each) do
    init_message
  end 
  
  it "should list the authors" do
    test_run do
      Given "a paper with an author"
      @paper = FactoryGirl.create :paper_author_tdd
      a = @paper.authors.first
      
      When "a user visits the paper page"
      visit paper_path(@paper)
      
      Then "it should show the author's name"
      expect(page).to have_text(a.name)
    end
  end
end

describe "Edit paper page", :type => :feature do
  
  before(:each) do
    init_message
  end 
  
  it "should allow to select up to five authors from a drop down" do
    test_run do
      Given "a paper"
      @paper = FactoryGirl.create :paper_tdd
      
      When "a user visits the paper's edit page"
      visit edit_paper_path(@paper)
      
      Then "it should have a select box for the first author"
      expect(page).to have_select('paper_author_id_1')
      
      Then "it should have a select box for the second author"
      expect(page).to have_select('paper_author_id_2')
      
      Then "it should have a select box for the third author"
      expect(page).to have_select('paper_author_id_3')
      
      Then "it should have a select box for the fourth author"
      expect(page).to have_select('paper_author_id_4')
      
      Then "it should have a select box for the fifth author"
      expect(page).to have_select('paper_author_id_5')
    end
  end
  
  it "should pre-select the actual authors in the drop downs" do
    test_run do
      Given "a paper with one author"
      @paper = FactoryGirl.create :paper_author_tdd
      @alan = @paper.authors.first
      
      When "a user visits the paper's edit page"
      visit edit_paper_path(@paper)
      
      Then "the first select box should show the authors name"
      expect(page).to have_select('paper_author_id_1', selected: @alan.name)
    end
  end
  
  it "should save changes to the author list" do
    test_run do
      @paper = FactoryGirl.create :paper_author_tdd
      @alan = @paper.authors.first
      peter = FactoryGirl.create(:author_tdd, first_name: 'Peter', last_name: 'Plagiarist')
      Given "a paper with one author"
      And "another author called '#{peter.name}'"
      
      When "a user visits the paper's edit page"
      visit edit_paper_path(@paper)
      
      And "the selects '#{peter.name}' as first author"
      select(peter.name, from: 'paper_author_id_1')
      
      And "submits the form"
      submit_form
      @paper.reload
      
      Then "'#{peter.name}' should be author of the paper"
      expect(@paper.authors).to include(peter)
      
      Then "'#{@alan.name}' should not be author of the paper"
      expect(@paper.authors).to_not include(@alan)
      
      Then "'#{peter.name}' should be the only author of the paper"
      expect(@paper.authors).to eq([peter])
    end
  end
end