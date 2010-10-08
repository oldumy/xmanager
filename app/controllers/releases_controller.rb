class ReleasesController < ApplicationController
  before_filter :load_release_by_id, :only => [:edit, :update, :destroy, :release, :turnback]

  def new
    project = Project.find(params[:project_id])
    @release = project.releases.build
  end

  def edit
  end

  def create
    project = Project.find(params[:project_id])
    @release = project.releases.build(params[:release])
    if @release.save
      redirect_to project_project_plannings_url(project)
    else
      render 'new'
    end
  end

  def update
    if @release.update_attributes(params[:release])
      redirect_to project_project_plannings_url(@release.project)
    else
      render 'edit'
    end
  end

  def destroy
    @release.destroy
    redirect_to project_project_plannings_url(@release.project)
  end

  # PUT /projects/:project_id/releases/:id/release
  def release
    flash[:notice] = t("notices.not_released") unless @release.release
    redirect_to project_project_plannings_url(@release.project)
  end

  # PUT /projects/:project_id/releases/:id/turnback
  def turnback 
    @release.turnback
    redirect_to project_project_plannings_url(@release.project)
  end

  private
  def load_release_by_id
    @release = Release.find(params[:id])
  end
end
