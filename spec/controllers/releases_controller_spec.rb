require 'spec_helper'

describe ReleasesController do

  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user
  end

  describe "GET 'new'" do
    it "should assign a release as @release" do
      project = Factory(:xmanager)
      release = Release.new(:project => project)
      Project.should_receive(:find).with(project.id).and_return(project)
      project.releases.should_receive(:build).and_return(release)

      get 'new', :project_id => project.id
      assigns(:release).should eq(release)
      response.should render_template('new')
    end
  end

  describe "POST 'create'" do
    describe 'with valid params' do
      it "should assign release as @release and then be redirected to the project plannings page" do
        project = Factory(:xmanager)
        release = Factory.build(:v_1, :project => nil)
        Project.should_receive(:find).with(project.id).and_return(project)
        project.releases.should_receive(:build).and_return(release)
        release.should_receive(:save).and_return(true)

        post 'create', :project_id => project.id
        assigns(:release).should eq(release)
        response.should redirect_to(project_project_plannings_url(project))
      end
    end
  end

  describe "GET 'edit'" do
    it "should assign the requested release as @release" do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)

      get :edit, :project_id => release.project.id, :id => release.id
      assigns(:release).should eq(release)
    end
  end

  describe "PUT 'update'" do
    describe 'with valid params' do
      before(:each) do
        @release = Factory(:v_1)
        Release.should_receive(:find).with(@release.id).and_return(@release)
        @release.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
      end

      it "should update the requested release" do
        put :update, :project_id => @release.project.id, :id => @release.id, :release => {'these' => 'params'}
      end

      it "should assign the requested release as @release" do
        put :update, :project_id => @release.project.id, :id => @release.id, :release => {'these' => 'params'}
        assigns(:release).should eq(@release)
      end

      it "should be redirected to the project plannings page" do
        put :update, :project_id => @release.project.id, :id => @release.id, :release => {'these' => 'params'}
        response.should redirect_to(project_project_plannings_path(@release.project))
      end
    end

    describe 'with invalid params' do
      before(:each) do
        @release = Factory(:v_1)
        Release.should_receive(:find).with(@release.id).and_return(@release)
        @release.should_receive(:update_attributes).and_return(false)
      end

      it "should assign the requested release as @release" do
        put :update, :project_id => @release.project.id, :id => @release.id
        assigns(:release).should eq(@release) 
      end

      it "should re-render the edit template" do
        put :update, :project_id => @release.project.id, :id => @release.id
        response.should render_template(:edit)
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should destroy the requested release" do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:destroy)

      delete :destroy, :project_id => release.project.id, :id => release.id
    end

    it "should redirect to the project plannings page" do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:destroy)

      delete :destroy, :project_id => release.project.id, :id => release.id
      response.should redirect_to(project_project_plannings_url(release.project))
    end
  end

  describe "PUT release" do
    it 'should release the requested release' do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:release)

      put :release, :project_id => release.project.id, :id => release.id
    end

    it 'should redirect to the project plannings page' do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:release)

      put :release, :project_id => release.project.id, :id => release.id
      response.should redirect_to(project_project_plannings_url(release.project))
    end
  end

  describe "PUT turnback" do
    it 'should turnback the requested release' do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:turnback)

      put :turnback, :project_id => release.project.id, :id => release.id
    end

    it 'should redirect to the project plannings page' do
      release = Factory(:v_1)
      Release.should_receive(:find).with(release.id).and_return(release)
      release.should_receive(:turnback)

      put :turnback, :project_id => release.project.id, :id => release.id
      response.should redirect_to(project_project_plannings_url(release.project))
    end
  end
end
