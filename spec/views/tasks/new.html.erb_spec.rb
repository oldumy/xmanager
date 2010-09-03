require 'spec_helper'

describe "tasks/new.html.erb" do
  before(:each) do
    assign(:task, stub_model(Task,
      :new_record? => true,
      :name => "MyString",
      :description => "MyText",
      :user_id => 1,
      :workload => 1.5,
      :progress => 1.5,
      :backlog_id => 1,
      :surplus_workload => 1.5
    ))
  end

  it "renders new task form" do
    render

    rendered.should have_selector("form", :action => tasks_path, :method => "post") do |form|
      form.should have_selector("input#task_name", :name => "task[name]")
      form.should have_selector("textarea#task_description", :name => "task[description]")
      form.should have_selector("input#task_user_id", :name => "task[user_id]")
      form.should have_selector("input#task_workload", :name => "task[workload]")
      form.should have_selector("input#task_progress", :name => "task[progress]")
      form.should have_selector("input#task_backlog_id", :name => "task[backlog_id]")
      form.should have_selector("input#task_surplus_workload", :name => "task[surplus_workload]")
    end
  end
end
