# encoding: utf-8
require 'spec_helper'

describe Backlog do
  before(:each) do
    @backlog = Factory.build(:backlog)
  end

  it "should create a new instance given valid attributes" do
    @backlog.save
    Backlog.should have(1).record
  end

  it "can't create backlog given invalid level" do
    @backlog.level = -1
    @backlog.should have(1).errors_on(:level)
    @backlog.level = "str"
    @backlog.should have(1).errors_on(:level)
  end

  it "can't create backlog given invalid :story_points" do
    @backlog.story_points = "str"
    @backlog.should have(1).errors_on(:story_points)
    @backlog.story_points = -1
    @backlog.should have(1).errors_on(:story_points)
  end

    it "can't create backlog given invalid :actual_story_points" do
    @backlog.actual_story_points = "str"
    @backlog.should have(1).errors_on(:actual_story_points)
    @backlog.actual_story_points = -1
    @backlog.should have(1).errors_on(:actual_story_points)
  end

  it "can't create backlog given invalid project" do
    @backlog.project = nil
    @backlog.save.should be_false
  end

  it "should associated created" do
    project = Factory(:project)
    backlog = Factory(:backlog, :project => nil, :project_id => project.id)
    lambda{ backlog.project.should_not be_nil }.should_not raise_error
  end

  it "should return right backlog_description" do
    role = Factory(:project_role)
    @backlog = Factory.build(:backlog, :project_role => role)
    @backlog.backlog_description.should == "作为#{role.role_name},我可以aaaaaaaaaaaaaa,以便bbbbbbbbbbbbb"
    role = Factory(:project_role)
    @backlog = Factory.build(:backlog, :description=>"美化",:project_role => role)
    @backlog.backlog_description.should == "美化"
  end
end
