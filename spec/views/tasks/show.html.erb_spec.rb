require 'spec_helper'

describe "tasks/show.html.erb" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "Name",
      :description => "MyText",
      :user_id => 1,
      :workload => 1.5,
      :progress => 1.5,
      :backlog_id => 1,
      :surplus_workload => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Name".to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.5.to_s)
    rendered.should contain(1.5.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain(1.5.to_s)
  end
end
