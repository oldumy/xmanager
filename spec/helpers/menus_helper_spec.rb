require 'spec_helper'

describe MenusHelper do
  context "Generate top menus for administrators" do
    it "sets 'users' as the selected menu" do
      doc = Nokogiri::HTML.parse(menus(Factory(:admin), :users))
      nodes = doc.xpath('//div/ul/li/a[@class="selected"]')
      nodes.length.should == 1
      nodes.first.parent["id"].should == "menus-users"
    end
  end

  context "Generate top menus for product managers" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:product_manager), :user_stories, '/projects/1'))
    end

    it "should have 5 menus" do
      @doc.xpath('//div/ul/li').length.should == 5
    end

    it "sets 'user_stories' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-user-stories"
      selected.first['href'].should == '/projects/1/backlogs'
    end
  end

  context "Generate top menus for project managers" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:project_manager), :user_stories))
    end

    it "should have 5 menus" do
      @doc.xpath('//div/ul/li').length.should == 5
    end

    it "sets 'user_stories' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-user-stories"
    end
  end

  context "Generate top menus for developers" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:developer), :user_stories))
    end

    it "should have 5 menus" do
      @doc.xpath('//div/ul/li').length.should == 5
    end

    it "sets 'user_stories' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-user-stories"
    end
  end
end