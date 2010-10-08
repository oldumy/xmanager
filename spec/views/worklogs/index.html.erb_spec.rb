require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'worklogs/index.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @task = Factory(:task)
    @worklogs = [
      @task.worklogs.create!(:remaining_hours => 2, :description => 'Description of the first'),
      @task.worklogs.create!(:remaining_hours => 4, :description => 'Description of the second')
    ]
  end

  it 'should show the task' do
    render

    rendered.should have_selector("#task-panel") do |div|
      div.should have_selector(:h1, :content => @task.name)
      div.should have_selector(:p, :content => @task.description)
    end
  end

  it 'should list the worklogs' do
    render

    rendered.should have_selector(".worklogs") do |ul|
      @worklogs.each do |worklog|
        ul.should have_selector("h1", :content => "Remaining Hours(#{worklog.remaining_hours})")
        ul.should have_selector("h1>span", :content => worklog.description)
      end
    end
  end
end
