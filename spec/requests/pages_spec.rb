require 'spec_helper'

describe "Static Pages" do

  describe "Home page" do

    it "should be present" do
      visit root_path
      page.should have_content('MC Custom')
    end
  end
end
