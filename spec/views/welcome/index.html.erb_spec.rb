require 'spec_helper'

describe 'welcome/index.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  it "should render administrators' menus" do
    current_user(:admin)
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector(:ul) do |ul|
        ul.should have_selector(:li, :id => "menus-users")
      end
    end
  end

  it "should render product managers' menus" do
    current_user(:product_manager)
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector(:ul) do |ul|
        ul.should have_selector(:li, :id => "menus-user-roles")
        ul.should have_selector(:li, :id => "menus-user-stories")
        ul.should have_selector(:li, :id => "menus-new-user-story")
        ul.should have_selector(:li, :id => "menus-tasks")
        ul.should have_selector(:li, :id => "menus-new-task")
      end
    end
  end
end
