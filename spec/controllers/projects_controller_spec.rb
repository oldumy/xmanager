require 'spec_helper'

describe ProjectsController do
  describe 'POST create' do
    describe 'with valid parameters' do
      it "redirects to the backlogs page" do
        project = Factory(:xmanager)
        project_attrs = Factory.attributes_for(:xmanager)

        Project.stub(:new).and_return(project)
        project.should_receive(:save).and_return(true)

        post_with Factory.build(:product_owner), :create, :project => project_attrs

        response.should redirect_to(project_backlogs_url(project))
      end
    end

    describe 'with invalid parameters' do
      before(:each) do
        @project = Factory.build(:xmanager)
        Project.stub(:new).and_return(@project)
        @project.should_receive(:save).and_return(false)
      end

      it "assigns a newly created but unsaved project as @project" do
        post_with Factory.build(:product_owner), :create
        assigns(:project).should be(@project)
      end

      it "re-renders the 'new' template" do
        post_with Factory.build(:product_owner), :create
        response.should render_template("new")
      end
    end
  end
end
