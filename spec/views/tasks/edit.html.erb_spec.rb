require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'tasks/edit.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
  end

  it 'should render the edit task form' do
    render
    rendered.should have_selector(".form-wrapper>form[@action='#{product_backlog_task_path(@task.product_backlog, @task)}']") do |form|
      form.should have_selector(:label, :for => 'task_name', :content => 'Name')
      form.should have_selector(:input, :name => 'task[name]', :value => @task.name)
      form.should have_selector(:label, :for => 'task_estimated_hours', :content => 'Estimated Hours')
      form.should have_selector(:input, :name => 'task[estimated_hours]', :value => @task.estimated_hours.to_s)
      form.should have_selector(:label, :for => 'task_description', :content => 'Description')
      form.should have_selector(:textarea, :name => 'task[description]', :content => @task.description)
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end


