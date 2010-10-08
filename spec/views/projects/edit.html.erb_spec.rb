require 'spec_helper'

describe 'projects/edit.html.erb' do
  it "should render edit project form" do
    @project = Factory(:xmanager)
    render

    rendered.should have_selector(:form, :action => project_path(@project), :method => 'post') do |form|
      form.should have_selector(".fields>p>label", :for => "project_name", :content => "Name")
      form.should have_selector(".fields>p>input#project_name", :name => "project[name]", :value => @project.name)
      form.should have_selector(".fields>p>label", :for => "project_description", :content => "Description")
      form.should have_selector(".fields>p>textarea#project_description", :name => "project[description]", :content => @project.description)
      form.should have_selector(".actions>button#project_submit", :type => "submit", :content => "Save")
      form.should have_selector(".actions>a", :href => projects_path, :content => "Back")
    end
  end
end
