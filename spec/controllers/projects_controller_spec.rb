require 'spec_helper'

describe ProjectsController do
  before(:each) do
    activate_authlogic
    UserSession.create Factory(:product_owner)
  end

  describe 'POST create' do
    describe 'with valid parameters' do
      it "redirects to the projects page" do
        project = Factory(:xmanager)
        project_attrs = Factory.attributes_for(:xmanager)

        Project.stub(:new).and_return(project)
        project.should_receive(:save).and_return(true)

        post :create, :project => project_attrs

        response.should redirect_to(projects_url)
      end
    end

    describe 'with invalid parameters' do
      before(:each) do
        @project = Factory.build(:xmanager)
        Project.stub(:new).and_return(@project)
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
