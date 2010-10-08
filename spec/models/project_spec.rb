require 'spec_helper'

describe Project do
  describe 'Project validation' do
    it "should not have a blank name" do
      project = Factory.build(:project, :name => nil)
      project.should have(2).errors_on(:name)
      
      project.name = ''
      project.should have(2).errors_on(:name)
    end

    it "should have a name with length between 1 to 20" do
      project = Factory.build(:project)
      project.should_not have(1).error_on(:name)

      project.name = 'a' * 21
      project.should have(1).error_on(:name)
    end

    it "should have a unique name" do
      project = Factory(:xmanager)
      lambda { Factory(:xmanager) }.should raise_error
    end

    it "should have a creater" do
      project = Factory.build(:project)
      project.should have(1).error_on(:creater)
    end
  end

  it "should associate with product backlogs" do
    Project.new.respond_to?(:product_backlogs).should be_true
  end

  it "should associate with releases" do
    Project.new.respond_to?(:releases).should be_true
  end

  it "should create an instance" do
    xmanager = Factory(:xmanager)
    xmanager.new_record?.should be_false
  end

  it "should return the projects created by oldumy" do
    xmanager, xamaze, sca = Factory(:xmanager), Factory(:xamaze), Factory(:sca)
    projects = Project.created_by_or_has_member(User.find_by_login("oldumy"))
    projects.count.should == 2
    projects.where(:name => xmanager.name).exists?.should be_true
    projects.where(:name => xamaze.name).exists?.should be_true
    projects.where(:name => sca.name).exists?.should be_false
  end

  it "should return the projects which have yanny as a team member" do
    xmanager, xamaze, sca = Factory(:xmanager), Factory(:xamaze), Factory(:sca)
    yanny = Factory(:yanny)
    xmanager.team_members.create!(:user => yanny)
    
    projects = Project.created_by_or_has_member(yanny)
    projects.count.should eql(1)
    projects.where(:name => xmanager.name).exists?.should be_true
    projects.where(:name => xamaze.name).exists?.should be_false
    projects.where(:name => sca.name).exists?.should be_false
  end

  it 'is not started' do
    xmanager = Factory(:xmanager)
    xmanager.stub_chain(:sprints, :on_air, :nil?).and_return(true)
    xmanager.started?.should be_false
  end

  it 'is started' do
    xmanager = Factory(:xmanager)
    xmanager.stub_chain(:sprints, :on_air, :nil?).and_return(false)
    xmanager.started?.should be_true
  end
end
