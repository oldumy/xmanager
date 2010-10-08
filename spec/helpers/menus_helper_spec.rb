require 'spec_helper'

describe MenusHelper do
  describe "Generate top menus for administrators" do
    it "sets 'users' as the selected menu" do
      doc = Nokogiri::HTML.parse(menus(Factory(:admin), :users))
      nodes = doc.xpath('//div/ul/li/a[@class="selected"]')
      nodes.length.should == 1
      nodes.first.parent["id"].should == "menus-users"
    end
  end

  describe "Generate top menus for product owners" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:oldumy), :product_backlogs, '/projects/1'))
    end

    it "should have these menus" do
      @doc.css("div>ul>li[@id='menus-team-members']").length.should == 1
      @doc.css("div>ul>li[@id='menus-project-plannings']").length.should == 1
      @doc.css("div>ul>li[@id='menus-product-backlogs']").length.should == 1
      @doc.css("div>ul>li[@id='menus-burndown-charts']").length.should == 1
      @doc.css("div>ul>li[@id='menus-sprint-backlogs']").length.should == 1
    end

    it "sets 'product_backlogs' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-product-backlogs"
      selected.first['href'].should == '/projects/1/product_backlogs'
    end
  end

  describe "Generate top menus for scrum masters" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:venus), :project_plannings))
    end

    it "should have these menus" do
      @doc.css("div>ul>li[@id='menus-product-backlogs']").length.should == 1
      @doc.css("div>ul>li[@id='menus-project-plannings']").length.should == 1
      @doc.css("div>ul>li[@id='menus-sprint-backlogs']").length.should == 1
      @doc.css("div>ul>li[@id='menus-burndown-charts']").length.should == 1
      @doc.css("div>ul>li[@id='menus-team-members']").length.should == 0
    end

    it "sets 'project_plannings' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-project-plannings"
    end
  end

  describe "Generate top menus for developers" do
    before(:each) do
      @doc = Nokogiri::HTML.parse(menus(Factory(:yanny), :project_plannings))
    end

    it "should have these menus" do
      @doc.css("div>ul>li[@id='menus-product-backlogs']").length.should == 1
      @doc.css("div>ul>li[@id='menus-project-plannings']").length.should == 1
      @doc.css("div>ul>li[@id='menus-sprint-backlogs']").length.should == 1
      @doc.css("div>ul>li[@id='menus-burndown-charts']").length.should == 1
      @doc.css("div>ul>li[@id='menus-team-members']").length.should == 0
    end

    it "sets 'project_plannings' as the selected menu" do
      selected = @doc.xpath('//div/ul/li/a[@class="selected"]')
      selected.length.should == 1
      selected.first.parent["id"].should == "menus-project-plannings"
    end
  end
end
