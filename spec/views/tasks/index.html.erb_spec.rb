require 'spec_helper'

describe "tasks/index.html.erb" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :name => "Name",
        :description => "MyText",
        :user_id => 1,
        :workload => 1.5,
        :progress => 1.5,
        :backlog_id => 1,
        :surplus_workload => 1.5
      ),
      stub_model(Task,
        :name => "Name",
        :description => "MyText",
        :user_id => 1,
        :workload => 1.5,
        :progress => 1.5,
        :backlog_id => 1,
        :surplus_workload => 1.5
      )
    ])
  end

  it "renders a list of tasks" do
    render
    rendered.should have_selector("tr>td", :content => "Name".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.5.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.5.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.5.to_s, :count => 2)
  end
end
