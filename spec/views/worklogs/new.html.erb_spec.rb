require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'worklogs/new.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
    @worklog = @task.worklogs.build
  end

  it 'should render the new worklog form' do
    render

    rendered.should have_selector(".form-wrapper>form", :action => task_worklogs_path(@task)) do |form|
      form.should have_selector("label", :for => "worklog_remaining_hours", :content => "Remaining Hours")
      form.should have_selector(".fields input", :name => "worklog[remaining_hours]")
      form.should have_selector("label", :for => "worklog_description", :content => "Description")
      form.should have_selector(".fields textarea", :name => "worklog[description]")
      form.should have_selector(".buttons button", :type => 'submit')
      form.should have_selector(".buttons a", :href => on_air_project_sprints_path(@task.product_backlog.project))
    end
  end
end
