require 'spec_helper'

describe SprintBacklogsController do

  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user

    @sprint = Factory(:sprint_1)
  end

  describe 'GET new' do
    describe 'assignment' do
      before(:each) do
        Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
        get :new, :sprint_id => @sprint.id
      end

      it 'should assign the sprint as @sprint' do
        assigns(:sprint).should eq(@sprint) 
      end
    end
  end

  describe 'POST create' do
    it 'should create sprint backlogs with the selected product backlogs' do
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
      ProductBacklog.should_receive(:find).with(1)
      ProductBacklog.should_receive(:find).with(2)
      @sprint.sprint_backlogs.should_receive(:create!).twice

      post :create, :sprint_id => @sprint.id, :backlogs => [1, 2]
    end

    it 'should redirect to the project plannings page' do
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
      ProductBacklog.should_receive(:find).with(1)
      ProductBacklog.should_receive(:find).with(2)
      @sprint.sprint_backlogs.should_receive(:create!).twice

      post :create, :sprint_id => @sprint.id, :backlogs => [1, 2]
      response.should redirect_to(project_project_plannings_url(@sprint.release.project))
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @sprint_backlog = @sprint.sprint_backlogs.create!(:product_backlog => Factory(:create_product_backlogs))
    end

    it 'should destroy the requsted sprint backlog' do
      SprintBacklog.should_receive(:find).with(@sprint_backlog.id).and_return(@sprint_backlog)
      @sprint_backlog.should_receive(:destroy)

      delete :destroy, :sprint_id => @sprint.id, :id => @sprint_backlog.id
    end

    it 'should redirect to the project plannings page' do
      SprintBacklog.should_receive(:find).with(@sprint_backlog.id).and_return(@sprint_backlog)
      @sprint_backlog.should_receive(:destroy)

      delete :destroy, :sprint_id => @sprint.id, :id => @sprint_backlog.id
      response.should redirect_to(project_project_plannings_url(@sprint_backlog.sprint.release.project))
    end
  end
end
