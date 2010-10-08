require File.dirname(__FILE__) + '/view_spec_helper'

describe "sprints/on_air.html.erb" do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    @project = Factory(:xmanager)
    current_user(:oldumy)
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@project))
    end
  end
end

describe 'product_backlogs/index.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @project = Factory(:xmanager)
  end

  it "should highlight menus-product-backlogs" do
    @product_backlogs = []
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector(:ul) do |ul|
        ul.should have_selector(:li, :id => "menus-product-backlogs") do |li|
          li.should have_selector(:a, :class => 'selected', :href => project_product_backlogs_path(@project))
        end
      end
    end
  end
end


describe 'product_backlogs/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @project = Factory(:xmanager)
    @product_backlog = @project.product_backlogs.build
  end

  it 'should highlight product backlog menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector(:ul) do |ul|
        ul.should have_selector(:li, :id => "menus-product-backlogs") do |li|
          li.should have_selector(:a, :class => 'selected', :href => project_product_backlogs_path(@project))
        end
      end
    end
  end
end

describe 'product_backlogs/edit.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @product_backlog = Factory(:create_product_backlogs)
  end

  it 'should highlight product backlog menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector(:ul) do |ul|
        ul.should have_selector(:li, :id => "menus-product-backlogs") do |li|
          li.should have_selector(:a, :class => 'selected', :href => project_product_backlogs_path(@product_backlog.project))
        end
      end
    end
  end
end

describe 'project_plannings/index.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  it 'should highlight project plannings menu' do
    current_user(:oldumy)
    @project = Factory(:xmanager)
    render
    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected',
                                :href => project_project_plannings_path(@project))
    end
  end
end

describe 'releases/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @release = Release.new(:project => Factory(:xmanager))
  end

  it 'should highlight project plannings menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected', 
                                :href => project_project_plannings_path(@release.project))
    end
  end
end

describe 'releases/edit.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @release = Factory(:v_1)
  end

  it 'should highlight project plannings menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected', 
                                :href => project_project_plannings_path(@release.project))
    end
  end
end

describe 'sprints/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    release = Factory(:v_1)
    @sprint = release.sprints.build
  end

  it 'should highlight project plannings menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected', 
                                :href => project_project_plannings_path(@sprint.release.project))
    end
  end
end

describe 'sprints/edit.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @sprint = Factory(:sprint_1)
  end

  it 'should highlight project plannings menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected', 
                                :href => project_project_plannings_path(@sprint.release.project))
    end
  end
end

describe 'sprint_backlogs/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @sprint = Factory(:sprint_1)
  end

  it 'should highlight project plannings menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-project-plannings>a",
                                :class => 'selected', 
                                :href => project_project_plannings_path(@sprint.release.project))
    end
  end
end

describe 'tasks/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    product_backlog = Factory(:create_product_backlogs)
    @task = product_backlog.tasks.build
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end

describe 'tasks/edit.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end

describe 'worklogs/new.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
    @worklog = @task.worklogs.build
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end

describe 'worklogs/index.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end

