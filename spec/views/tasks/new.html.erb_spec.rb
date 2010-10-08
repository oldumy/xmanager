require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'tasks/new.html.erb' do
  before(:each) do
    current_user(:oldumy)
    product_backlog = Factory(:create_product_backlogs)
    @task = product_backlog.tasks.build
  end

  it 'should render the new task form' do
    render
    rendered.should have_selector(".form-wrapper>form[@action='#{product_backlog_tasks_path(@task.product_backlog)}']") do |form|
      form.should have_selector(:label, :for => 'task_name', :content => 'Name')
      form.should have_selector(:input, :name => 'task[name]')
      form.should have_selector(:label, :for => 'task_team_member_id', :content => 'Assign To')
      form.should have_selector(:select, :name => 'task[team_member_id]')
      form.should have_selector(:label, :for => 'task_estimated_hours', :content => 'Estimated Hours')
      form.should have_selector(:input, :name => 'task[estimated_hours]')
      form.should have_selector(:label, :for => 'task_description', :content => 'Description')
      form.should have_selector(:textarea, :name => 'task[description]')
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end


