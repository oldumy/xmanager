# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProjectRole do

  it "should associated a project after project_role created" do
    @project_role = Factory.build(:project_role)
    @project_role.project.should_not == nil
  end
  it "should created failed with same role_name" do
    @project = Factory.create(:project)
    @project_role = Factory.create(:project_role,:role_name => "aaa", :project => @project)
    @another_project_role = Factory.build(:project_role,:role_name => "aaa", :project => @project)
    @another_project_role.valid?.should be_false
    @another_project_role.should have(1).errors_on(:role_name)
  end
  it "should created failed with blank attributes" do
    @project_role = Factory.build(:project_role, :role_name => nil,:project => nil)
    @project_role.valid?.should be_false
    @project_role.should have(1).errors_on(:role_name)
    @project_role.should have(1).errors_on(:project)
  end
  it "should has two backlogs associated" do
    @project_role = Factory.create(:project_role)
    backlogs = [Factory(:backlog), Factory(:backlog)]
    backlogs.each do |backlog|
      backlog.project_role = @project_role
      backlog.save
    end
    @project_role.should have(2).backlogs
  end
end
