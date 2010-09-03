# encoding: utf-8
require 'spec_helper'

describe Sprint do

  it "should failed with blank attributs when create" do
    @sprint = Factory.build(:sprint, :name => nil, :project => nil)
    @sprint.valid?.should be_false
    @sprint.should have(1).errors_on(:name)
    @sprint.should have(1).errors_on(:project)
  end

  it "should has two backlogs associated" do
    @sprint = Factory.create(:sprint)
    backlogs = [Factory(:backlog), Factory(:backlog)]
    backlogs.each do |backlog|
      backlog.sprint = @sprint
      backlog.save
    end
    @sprint.should have(2).backlogs
  end

  it "should failed with start_time greater than end_time" do
    @sprint = Factory.build(:sprint, :start_time => "2010-09-01", :end_time => "2010-08-30")
    @sprint.valid?.should be_false
    @sprint.should have(1).errors
  end

end

