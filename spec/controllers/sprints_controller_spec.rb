require 'spec_helper'

describe SprintsController do
  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user

    @release = Factory(:v_1)
  end

  describe 'GET new' do
    it 'should assign a new sprint as @sprint' do
      sprint = @release.sprints.build
      Release.should_receive(:find).with(@release.id).and_return(@release)
      @release.sprints.should_receive(:build).and_return(sprint)

      get :new, :release_id => @release.id
      assigns(:sprint).should be(sprint)
    end
  end

  describe 'GET edit' do
    before(:each) do 
      @sprint = Factory(:sprint_1)
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)

      get :edit, :id => @sprint.id
    end

    it 'should assign the requested sprint as @sprint' do
      assigns(:sprint).should eq(@sprint)
    end
  end

  describe 'POST create' do
    before(:each) do
      @sprint = Factory.build(:sprint_1)
      Release.should_receive(:find).with(@release.id).and_return(@release)
      @release.sprints.should_receive(:build).and_return(@sprint)
    end
    
    describe 'assignment' do
      before(:each) do
        @sprint.stub(:save)
        post :create, :release_id => @sprint.release.id
      end

      it 'should assign the sprint as @sprint' do
        assigns(:sprint).should be(@sprint)
      end
    end

    describe 'with valid params' do
      it 'should redirect to the project plannings page' do
        @sprint.should_receive(:save).and_return(true)

        post :create, :release_id => @release.id
        response.should redirect_to(project_project_plannings_url(@release.project))
      end
    end

    describe 'with invalid params' do
      it 'should re-render the new form' do
        @sprint.should_receive(:save).and_return(false)

        post :create, :release_id => @release.id
        response.should render_template('new')
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
    end

    describe 'assignment' do
      before(:each) do
        @sprint.should_receive(:update_attributes)
        put :update, :id => @sprint.id
      end

      it 'should assign the requested sprint as @sprint' do
        assigns(:sprint).should eq(@sprint)
      end
    end

    describe 'with valid params' do
      it 'should redirect to the project plannings page of the project' do
        @sprint.should_receive(:update_attributes).and_return(true)

        put :update, :id => @sprint.id
        response.should redirect_to(project_project_plannings_url(@sprint.release.project))
      end
    end

    describe 'with invalid params' do
      it 'should re-render the edit sprint page' do
        @sprint.should_receive(:update_attributes).and_return(false)

        put :update, :id => @sprint.id
        response.should render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
    end

    it 'should destroy the requested sprint' do
      @sprint.should_receive(:destroy)
      delete :destroy, :id => @sprint.id
    end

    it 'should redirect to the project plannings page' do
      @sprint.should_receive(:destroy)
      delete :destroy, :id => @sprint.id
      response.should redirect_to(project_project_plannings_url(@sprint.release.project))
    end
  end

  describe 'PUT start' do
    before(:each) do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
    end

    it 'should start the requested sprint' do
      @sprint.should_receive(:start).and_return(true)

      put :start, :id => @sprint.id
    end
    
    it 'should redirect to on air sprint page' do
      @sprint.should_receive(:start).and_return(true)
      put :start, :id => @sprint.id
      response.should redirect_to(on_air_project_sprints_url(@sprint.release.project))
    end

    it 'should not start the requested sprint' do
      @sprint.should_receive(:start).and_return(false)

      put :start, :id => @sprint.id
      flash[:notice].should == "No sprint backlog found."
      response.should redirect_to(project_project_plannings_url(@sprint.release.project))
    end
  end

  describe 'GET on_air' do
    it 'should assign the project as @project' do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Project.should_receive(:find).with(@release.project.id).and_return(@release.project)

      get :on_air, :project_id => @release.project.id
      assigns(:project).should eq(@release.project)
    end

    it 'should assign the on air sprint as @sprint' do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Project.should_receive(:find).with(@release.project.id).and_return(@release.project)
      @release.project.sprints.should_receive(:on_air).and_return(@sprint)

      get :on_air, :project_id => @release.project.id
      assigns(:sprint).should eq(@sprint)
    end
  end

  describe 'PUT close' do
    before(:each) do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
    end

    it 'should close the requested sprint' do
      @sprint.should_receive(:close)

      put :close, :id => @sprint.id
    end

    it 'should redirect to the on air sprint page' do
      @sprint.should_receive(:close).and_return(true)
      put :close, :id => @sprint.id
      
      response.should redirect_to(on_air_project_sprints_url(@sprint.release.project))
    end

    it 'should notice not closed' do
      @sprint.should_receive(:close).and_return(false)

      put :close, :id => @sprint.id
      flash[:notice].should == 'A sprint backlog is still open.'
    end
  end

  describe 'PUT reopen' do
    before(:each) do
      @sprint = @release.sprints.create!(Factory.attributes_for(:sprint_1))
      Sprint.should_receive(:find).with(@sprint.id).and_return(@sprint)
    end

    it 'should reopen the requested sprint' do
      @sprint.should_receive(:reopen)
      put :reopen, :id => @sprint.id
    end

    it 'should redirect to the on air sprint page' do
      @sprint.should_receive(:reopen)
      put :reopen, :id => @sprint.id

      response.should redirect_to(on_air_project_sprints_url(@sprint.release.project))
    end
  end
end
