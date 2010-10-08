require 'spec_helper'

describe BurndownChartsController do
  before(:each) do
    activate_authlogic
    UserSession.create Factory(:oldumy)
  end

  describe 'GET index' do
    it 'should notice project is not started' do
      @project = Factory(:xmanager)
      Project.should_receive(:find).with(@project.id).and_return(@project)
      @project.should_receive(:started?).and_return(false)

      get :index, :project_id => @project.id
      flash[:notice].should == 'Project is not started.'
    end
  end
end
