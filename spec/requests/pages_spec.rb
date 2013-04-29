require 'spec_helper'

describe "Static Pages" do

  describe "Home page" do
    before { visit root_path }
    it "should be present" do
      page.should have_content('MC Custom')
    end
  end

  describe "Service Details Page" do
    before { visit services_path }
    it "should be present" do
      page.should have_content('Services')
    end
  end
end
