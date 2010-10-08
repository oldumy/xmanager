require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'product_backlogs/index.html.erb' do
  before(:each) do
    @project = Factory(:xmanager)
    @product_backlogs = [Factory(:create_product_backlogs), Factory(:list_product_backlogs)]
    @product_backlogs.stub(:total_pages).and_return(1)
    current_user(:tower)
    render
  end

  it "should show product backlogs" do
    @product_backlogs.each do |backlog|
      rendered.should have_selector("div#product-backlog-#{backlog.id}") do |div|
        div.should have_selector(:h1, :content => backlog.name)
        div.should have_selector("h1>span", :content => "Priority(#{backlog.priority})")
        div.should have_selector("h1>span", :content => "Estimated Story Points(#{backlog.estimated_story_points})")
        div.should have_selector("p>label", :content => "Description")
        div.should have_selector("p", :content => backlog.description)
        div.should have_selector("p>label", :content => "Acceptance Criteria")
        div.should have_selector("p", :content => backlog.acceptance_criteria)
      end
    end
  end

  it "should render the management links" do
    @product_backlogs.each do |backlog|
      rendered.should have_selector("div#product-backlog-#{backlog.id}") do |div|
        div.should have_selector("h1>span.actions") do |span|
          span.should have_selector(:a, :href => edit_product_backlog_path(backlog), :content => "Edit")
          span.should have_selector(:a, :href => product_backlog_path(backlog), 'data-method' => 'delete', :content => "Delete")
        end
      end
    end
  end

  it "should have a new product backlog button" do
    rendered.should have_selector("#bottom-buttons>a", :content => "New", :href => new_project_product_backlog_path(@project))
  end
end
