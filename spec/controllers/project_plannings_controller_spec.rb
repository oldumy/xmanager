require 'spec_helper'

describe ProjectPlanningsController do
  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user
  end

  describe "GET 'index'" do
    it "should assign a project as @project" do
      project = Factory(:xmanager)
      Project.should_receive(:find).with(project.id).and_return(project)

      get 'index', :project_id => project.id
      assigns(:project).should eq(project)
      response.should render_template('index')
    end
  end
end
