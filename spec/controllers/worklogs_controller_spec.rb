require 'spec_helper'

describe WorklogsController do
  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user

    @task = Factory(:task)
  end

  describe 'GET index' do
    it 'should assign the task as @task' do
      Task.should_receive(:find).with(@task.id).and_return(@task)
      get :index, :task_id => @task.id
      assigns(:task).should eq(@task)
    end

    it 'should assign the worklogs as @worklogs' do
      worklogs = [
        @task.worklogs.create!(:remaining_hours => 2, :description => "Description of the first"),
        @task.worklogs.create!(:remaining_hours => 4, :description => "Description of the second")
      ]
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.should_receive(:worklogs).and_return(worklogs)

      get :index, :task_id => @task.id
      assigns(:worklogs).should eq(worklogs)
    end
  end

  describe 'GET new' do
    it 'should assign a newly worklog as @worklog' do
      worklog = @task.worklogs.build
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.worklogs.should_receive(:build).and_return(worklog)

      get :new, :task_id => @task.id
      assigns(:worklog).should eq(worklog)
    end
  end

  describe 'POST create' do
    before(:each) do
      @worklog = @task.worklogs.build
      Task.should_receive(:find).with(@task.id).and_return(@task)
      @task.worklogs.should_receive(:build).and_return(@worklog)
    end

    describe 'with valid params' do
      it 'should redirect to the on air sprint page' do
        @worklog.should_receive(:save).and_return(true)

        post :create, :task_id => @task.id
        response.should redirect_to(on_air_project_sprints_url(@task.product_backlog.project))
      end
    end

    describe 'with invalid params' do
      before(:each) do 
        @worklog.should_receive(:save).and_return(false)
        post :create, :task_id => @task.id
      end

      it 'should assign the newly worklog as @worklog' do
        assigns(:worklog).should eq(@worklog)
      end

      it "should re-render the 'new' template" do
        response.should render_template('new')
      end
    end
  end

  describe 'GET edit' do
    it 'should assign the requested worklog as @worklog' do
      worklog = @task.worklogs.create!(Factory.attributes_for(:worklog))
      Worklog.should_receive(:find).with(worklog.id).and_return(worklog)

      get :edit, :task_id => @task.id, :id => worklog.id
      assigns(:worklog).should eq(worklog)
    end
  end

  describe 'PUT update' do
    before(:each) do
      @worklog = @task.worklogs.create!(Factory.attributes_for(:worklog))
      Worklog.should_receive(:find).with(@worklog.id).and_return(@worklog)
    end

    describe 'with valid params' do
      it 'should redirect to the on air sprint page' do
        @worklog.should_receive(:update_attributes).and_return(true)

        put :update, :task_id => @task.id, :id => @worklog.id
        response.should redirect_to(task_worklogs_url(@worklog.task))
      end
    end

    describe 'with invalid params' do
      before(:each) do 
        @worklog.should_receive(:update_attributes).and_return(false)
        put :update, :task_id => @task.id, :id => @worklog.id
      end

      it 'should assign the newly worklog as @worklog' do
        assigns(:worklog).should eq(@worklog)
      end

      it "should re-render the 'edit' template" do
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @worklog = @task.worklogs.create!(Factory.attributes_for(:worklog))
      Worklog.should_receive(:find).with(@worklog.id).and_return(@worklog)
    end

    it 'should delete the requested worklog' do
      @worklog.should_receive(:destroy)
      delete :destroy, :task_id => @task.id, :id => @worklog.id
    end

    it 'should be redirect to the worklogs page' do
      @worklog.should_receive(:destroy)
      delete :destroy, :task_id => @task.id, :id => @worklog.id
      response.should redirect_to(task_worklogs_url(@task))
    end
  end
end
