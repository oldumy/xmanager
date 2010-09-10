require 'spec_helper'

describe 'projects/edit.html.erb' do
  it "should render edit project form" do
    @project = Factory(:xmanager)
    render

    rendered.should have_selector(:form, :action => project_path(@project), :method => 'post') do |form|
      form.should have_selector("p>input#project_name", :name => "project[name]", :value => @project.name)
      form.should have_selector("p>textarea#project_description", :name => "project[description]", :content => @project.description)
      form.should have_selector("button#project_submit", :type => "submit")
      form.should have_selector("a", :href => projects_path)
    end
  end
end
