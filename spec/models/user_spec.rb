require 'spec_helper'

describe User do
  it "should return the users which are members of the specific project" do
    project = Factory(:xmanager)
    project.team_members.create!(:user => Factory(:tower))
    project.team_members.create!(:user => Factory(:venus))
    members = User.in_project(project)
    members.count.should == 2
  end

  it "should return the users which are not administrators" do
    admin, oldumy, tower, venus = Factory(:admin), Factory(:oldumy), Factory(:tower), Factory(:venus)

    users = User.not_admin
    users.count.should == 3

    User.not_admin(:except => []).count.should == 3
    User.not_admin(:except => nil).count.should == 3

    users = User.not_admin(:except => oldumy)
    users.count.should == 2

    users = User.not_admin(:except => [tower, venus])
    users.count.should == 1
  end

  it "should associated a role after user created" do
    @user = Factory.build(:admin)
    @user.role.should_not == nil
  end
  it "should created failed with invalid minimum attributs" do
    @user = Factory.build(:admin)
    @user.login="a"
    @user.valid?.should be_false
    #include errors in authlogic
    @user.should have(3).errors_on(:login)
  end
  it "should created failed with invalid maximum attributs" do
    @user = Factory.build(:admin)
    @user.login="a"*41
    @user.name="s"*41
    @user.valid?.should be_false
    @user.should have(1).errors_on(:login)
    @user.should have(1).errors_on(:name)
  end
  it "should created failed with same login" do
    Factory.create(:admin,:login => "aaa")
    @user = Factory.build(:admin,:login => "aaa")
    @user.valid?.should be_false
  end
end

