class SprintBacklogsController < ApplicationController
  before_filter :load_sprint, :except => :destroy

  def new
  end

  def create
    params[:backlogs].each do |backlog|
      @sprint.sprint_backlogs.create!(:product_backlog => ProductBacklog.find(backlog))
    end
    redirect_to project_project_plannings_url(@sprint.release.project)
  end

  def destroy
    sprint_backlog = SprintBacklog.find(params[:id])
    sprint_backlog.destroy

    redirect_to project_project_plannings_url(sprint_backlog.sprint.release.project)
  end

  private
  def load_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end
end
