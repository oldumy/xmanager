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
    class TestModel
      include ActiveModel::Validations
      attr_accessor :name
      validates :name, :presence => true
    end
    model = TestModel.new
    model.valid?.should be_false
    error_box = <<-ERROR_BOX
<div id=\"error_explanation\"><h2>Save &lt;span class=&quot;translation_missing&quot;&gt;en, models, names, test_model&lt;&#47;span&gt; failed, 1 error(s) found</h2><ul><li><label>Name</label> can&#39;t be blank</li></ul></div>
    ERROR_BOX

    errors_of(model).should == error_box.chop
  end

  it "should render a no record found notice" do
    no_record_found(true).should == "<p id=\"no-record-found\">No record found.</p>"
  end

  it "should not render a no record found notice" do
    no_record_found(false).should == ""
  end
end
