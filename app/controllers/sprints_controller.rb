class SprintsController < ApplicationController
  before_filter :load_sprint, :except => [:new, :create, :on_air]
  
  def new
    release = Release.find(params[:release_id])
    @sprint = release.sprints.build
  end

  def edit
  end

  def create
    release = Release.find(params[:release_id])
    @sprint = release.sprints.build(params[:sprint])
    if @sprint.save
      redirect_to project_project_plannings_url(@sprint.release.project)
    else
      render :action => "new"
    end
  end

  def update
    if @sprint.update_attributes(params[:sprint])
      redirect_to project_project_plannings_url(@sprint.release.project)
    else
      render :action => "edit"
    end
  end

  def destroy
    @sprint.destroy
    redirect_to project_project_plannings_url(@sprint.release.project)
  end

  # PUT /projects/:project_id/sprints/:id/start
  def start
    if @sprint.start
      redirect_to on_air_project_sprints_url(@sprint.release.project)
    else
      flash[:notice] = t("notices.sprint_not_started")
      redirect_to project_project_plannings_url(@sprint.release.project)
    end
  end

  def close
    flash[:notice] = t("notices.sprint_not_closed") unless @sprint.close
    redirect_to on_air_project_sprints_url(@sprint.release.project)
  end

  # GET /projects/:project_id/sprints/reopen
  def reopen 
    @sprint.reopen
    redirect_to on_air_project_sprints_url(@sprint.release.project)
  end

  # GET /projects/:project_id/sprints/on_air
  def on_air
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.on_air
  end

  private
  def load_sprint
    @sprint = Sprint.find(params[:id])
  end
end
