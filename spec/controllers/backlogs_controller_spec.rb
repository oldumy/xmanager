# encoding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BacklogsController do
  before(:all) do
    @admin = Factory.build(:user, :role => Factory.build(:role, :role_name => 'administrators'))
    @product_owners = Factory.build(:user, :role => Factory.build(:role, :role_name => 'product_owners'))
  end
  before(:each) do
    @project = Factory.create(:project)
    @backlog = Factory.create(:backlog, :project => @project)
  end

  it "should get errors for administrator" do
    get_with(@admin,:index, :project_id => @project.id)
    response.should be_redirect
  end

  it "get index" do
    get_with(@product_owners,:index, :project_id => @project.id)
    response.should be_success
  end

  it "get show" do
    get_with(@product_owners,:show, :project_id => @project.id, :id => @backlog.id)
    response.should be_success
    
  end
end

