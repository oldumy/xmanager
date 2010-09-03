# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  it "should associated a role after user created" do
    @user = Factory.build(:user)
    @user.role.should_not == nil
  end
  it "should created failed with invalid minimum attributs" do
    @user = Factory.build(:user)
    @user.login="a"
    @user.valid?.should be_false
    #include errors in authlogic
    @user.should have(3).errors_on(:login)
  end
  it "should created failed with invalid maximum attributs" do
    @user = Factory.build(:user)
    @user.login="a"*41
    @user.name="s"*41
    @user.valid?.should be_false
    @user.should have(1).errors_on(:login)
    @user.should have(1).errors_on(:name)
  end
  it "should created failed with same login" do
    Factory.create(:user,:login => "aaa")
    @user = Factory.build(:user,:login => "aaa")
    @user.valid?.should be_false
  end
end

