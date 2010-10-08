require 'spec_helper'

describe TasksController do

  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user

    @product_backlog = Factory(:create_product_backlogs)
    @project = @product_backlog.project
    @task = Factory(:task)
  end

  describe 'GET new' do
    it 'should assign a project as @project' do
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
      get :new, :product_backlog_id => @product_backlog.id
      assigns(:project).should eq(@project)
    end

    it 'should assign a newly task as @task' do
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
      @product_backlog.tasks.should_receive(:build).and_return(@task)
      get :new, :product_backlog_id => @product_backlog.id
      assigns(:task).should eq(@task)
    end
  end

  describe 'POST create' do
    before(:each) do
      ProductBacklog.should_receive(:find).with(@product_backlog.id).and_return(@product_backlog)
      @product_backlog.tasks.should_receive(:build).and_return(@task)
    end

    describe 'with valid params' do
      it 'should redirect to the on air sprint page' do
        @task.should_receive(:save).and_return(true)

        post :create, :product_backlog_id => @product_backlog.id
        response.should redirect_to(on_air_project_sprints_url(@project))
      end
    end

    describe 'with invalid params' do
      it "should re-render 'new' template" do
        @task.should_receive(:save).and_return(false)

        post :create, :product_backlog_id => @product_backlog.id
        response.should render_template('new')
      end
    end
  end

  describe 'GET edit' do
    it 'should assign the requested task as @task' do
      Task.should_receive(:find).with(@task.id).and_return(@task)

      get :edit, :id => @task.id
      assigns(:task).should eq(@task)
    end
  end
 
  describe 'PUT update' do
    before(:each) do
      Task.should_receive(:find).with(@task.id).and_return(@task)
    end

    describe 'with valid params' do
      it 'should redirect to the on air sprint page' do
        @task.should_receive(:update_attributes).and_return(true)

        post :update, :id => @task.id
        response.should redirect_to(on_air_project_sprints_url(@project))
      end
    end

    describe 'with invalid params' do
      it "should re-render 'edit' template" do
        @task.should_receive(:update_attributes).and_return(false)

        post :update, :id => @task.id
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do 
    it "should destroy the requested task" do
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.should_receive(:destroy)
      delete :destroy, :id => @task.id
    end

    it "should redirect to the on air sprint page" do
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.should_receive(:destroy)
      delete :destroy, :id => @task.id

      response.should redirect_to(on_air_project_sprints_url(@product_backlog.project))
    end
  end

  describe 'PUT close' do
    it 'should close the requested task' do
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.should_receive(:close)
      put :close, :id => @task.id
    end
  end

  describe 'PUT reopen' do
    it 'should reopen the requested task' do
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.should_receive(:reopen)
      put :reopen, :id => @task.id
    end
  end
end
