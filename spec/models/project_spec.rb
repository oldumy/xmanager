require 'spec_helper'

describe Project do
  describe 'Project validation' do
    it "should have a name" do
      project = Factory.build(:project, :name => nil)
      project.valid?.should be_false
      project.should have(1).errors_on(:name)
    end

    it "should have a unique name" do
      factory = Factory(:project)
      lambda { Factory(:project, :name => factory.name) }.should raise_error
    end
  end

  describe 'Project association' do
    before(:all) do
      @project = Factory(:project)
      @project_id = @project.id
    end
    
    it "should has many backlogs" do
      [Factory(:backlog, :project => @project), Factory(:backlog, :project => @project)]
      @project.should have(2).backlogs
    end

    it "should has many sprints" do
      Factory(:sprint, :project_id => @project_id)
      @project.should have(1).sprint
    end

    it "should has many project-roles" do
      Factory(:project_role, :project => @project)
      @project.should have(1).project_role
    end
  end
end
