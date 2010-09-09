require 'spec_helper'

describe ApplicationHelper do
  it "should set app title as the top banner" do
    app_top_banner(nil).should == content_tag(:h1, Settings.app.title)
    app_top_banner(Project.new).should == content_tag(:h1, Settings.app.title)
    app_top_banner(Project.new(:name => '')).should == content_tag(:h1, Settings.app.title)
  end

  it "should use the name of the project as the top banner" do
    project = Factory.build(:xmanager)
    app_top_banner(project).should == content_tag(:h1, project.name)
  end

  it "should generate a valid error box" do
    project = Project.new
    project.save
    error_box = <<-ERROR_BOX
<div id="error_explanation"><h2>Save Project failed, 1 error(s) found</h2><ul><li><label>Name</label> can't be blank</li></ul></div>
    ERROR_BOX

    errors_of(project).should == error_box.chop
  end
end
