require 'spec_helper'

describe 'projects/new.html.erb' do
  it "should render new project form" do
    @project = Project.new
    render

    rendered.should have_selector(:form, :action => projects_path, :method => 'post') do |form|
      form.should have_selector("input#project_name", :name => "project[name]")
      form.should have_selector("textarea#project_description", :name => "project[description]")
      form.should have_selector("button", :type => "submit")
      form.should have_selector("a", :href => projects_path)
    end
  end
end
