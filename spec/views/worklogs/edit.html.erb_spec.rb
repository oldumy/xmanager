require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'worklogs/edit.html.erb' do
  def content_for(name)
    view.instance_variable_get(:@_content_for)[name]
  end

  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
    @worklog = @task.worklogs.create!(Factory.attributes_for(:worklog))
  end

  it 'should highlight sprint backlogs menu' do
    render

    content_for(:menus).should have_selector(:div, :id => "main-menu") do |menu|
      menu.should have_selector("ul>li#menus-sprint-backlogs>a",
                                :class => 'selected', 
                                :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end

  it 'should render the edit worklog form' do
    render

    rendered.should have_selector(".form-wrapper>form[@action='#{task_worklog_path(@task, @worklog)}']") do |form|
      form.should have_selector(".fields input", :name => "worklog[remaining_hours]", :value => @worklog.remaining_hours.to_s)
      form.should have_selector(".fields textarea", :name => "worklog[description]", :content => @worklog.description)
      form.should have_selector(".buttons button", :type => 'submit')
      form.should have_selector(".buttons a", :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end
