require 'spec_helper'

describe TeamMembersController do
  before(:each) do
    activate_authlogic
    @current_user = Factory(:oldumy)
    UserSession.create @current_user

    @project = Factory(:xmanager)
  end

  describe "GET 'index'" do
    it "should be successful" do
      @candidates = 'candidates'
      Project.should_receive(:find).with(@project.id).and_return(@project)
      User.should_receive(:in_project).and_return([])
      User.should_receive(:not_admin).with(:except => []).and_return(@candidates)
      get 'index', :project_id => @project.id

      assigns(:project).should be(@project)
      assigns(:candidates).should be(@candidates)
    end
  end

  describe "POST 'create'"  do
    it "should add the selected candidates as team members" do
      Project.should_receive(:find).with(@project.id).and_return(@project)
      User.should_receive(:find).with(1)
      User.should_receive(:find).with(2)
      @project.team_members.should_receive(:create!).twice
      post 'create', :project_id => @project.id, :candidates => [1, 2]

      response.should redirect_to(project_team_members_url(@project))
    end
  end

  describe "delete 'destroy'" do
    it "should delete the selected team member" do
      Project.should_receive(:find).with(@project.id).and_return(@project)
      TeamMember.should_receive(:find).with(1)
      @project.team_members.should_receive(:delete)
      delete 'destroy', :project_id => @project.id, :id => 1

      response.should redirect_to(project_team_members_url(@project))
    end
  end

end
