require 'spec_helper'

describe ProjectsController do
  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user
  end

  describe 'GET index' do
    it "should filter project by the creater" do
      projects = [Factory(:xmanager), Factory(:xamaze)]
      Project.should_receive(:created_by_or_has_member).with(@current_user).and_return(projects)
      projects.should_receive(:paginate).and_return(projects)
      get :index
    end
  end

  describe 'POST create' do
    before(:each) do
      @project = Factory(:xmanager)
      Project.should_receive(:new).and_return(@project)
    end

    describe 'with valid parameters' do
      it "redirects to the projects page" do
        @project.should_receive(:save).and_return(true)

        post :create
        response.should redirect_to(projects_url)
      end
    end

    describe 'with invalid parameters' do
      before(:each) do
        @project.should_receive(:save).and_return(false)
      end

      it "assigns a newly created but unsaved project as @project" do
        post :create
        assigns(:project).should be(@project)
      end

      it "re-renders the 'new' template" do
        post :create
        response.should render_template("new")
      end
    end
  end

  describe 'PUT update' do
    before(:each) do
      @project = Factory(:xmanager)
      Project.should_receive(:find).with(@project.id).and_return(@project)
    end

    describe 'with valid parameters' do
      it 'should redirect to the projects page' do
        @project.should_receive(:update_attributes).and_return(true)

        put :update, :id => @project.id
        response.should redirect_to(projects_url)
      end
    end

    describe 'with invalid parameters' do
      it "re-renders the 'edit' template" do
        @project.should_receive(:update_attributes).and_return(false)
        put :update, :id => @project.id
        response.should render_template("edit")
      end
    end
  end
end
