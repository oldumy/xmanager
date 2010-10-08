class TeamMembersController < ApplicationController
  before_filter :load_project

  def index
    members = User.in_project(@project)
    @candidates = User.not_admin(:except => members)
  end

  def create
    unless params[:candidates].blank?
      params[:candidates].each do |candidate|
        @project.team_members.create!(:user => User.find(candidate))
      end
    end
    redirect_to project_team_members_url(@project)
  end

  def destroy
    @project.team_members.delete(TeamMember.find(params[:id]))
    redirect_to project_team_members_url(@project)
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
  end
end
