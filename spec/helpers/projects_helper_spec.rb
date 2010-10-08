require 'spec_helper'

describe ProjectsHelper do
  before(:each) do
    @xmanager = Factory(:xmanager)
  end

  it "should link to the team members page" do
    magic_project_path(@xmanager).should == project_team_members_path(@xmanager)
  end

  it "should link to the project plannings page" do
    @xmanager.team_members.create!(:user => @xmanager.creater)
    magic_project_path(@xmanager).should == project_project_plannings_path(@xmanager)
  end
end
