# encoding: utf-8

require 'spec_helper'

describe "backlogs helper test" do
  include BacklogsHelper

  before(:each) do
    @project = Factory.create(:project,:name => 'project1')
  end

  it "should return project roles" do
    Factory.create(:project_role,:role_name => 'role_name1', :project => @project)
    roles_for_project[0].role_name.should == 'role_name1'
  end

  it "should return sprint name" do
    Factory.create(:sprint, :name => 'sprint_name1', :project => @project)
    name_for_sprint[0].name.should == 'sprint_name1'
  end

  it "should return desc" do
    project_role = Factory.build(:project_role, :role_name => 'name1')
    backlog = Factory.build(:backlog, :project_role => project_role)
    desc(backlog).should == "作为name1，我可以：aaaaaaaaaaaaaa"

    backlog.project_role = nil
    desc(backlog).should == "我可以：aaaaaaaaaaaaaa"
  end

  it "should return status select html" do
    @backlog = Factory.build(:backlog, :project => @project, :status => 1)
    status_select.should =~ /selected='selected'>已完成/
  end
end