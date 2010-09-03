# encoding : utf-8
class SprintsController < ApplicationController
  include PaintAssistent
  
  filter_access_to :all
  before_filter :load_project
  before_filter :load_sprint, :except => [:index, :new, :create]
  
  def index
    @sprints = @project.sprints
  end

  def show
    @data = gen_sprint_burn_down_data(@sprint)
  end

  def new
    @sprint = @project.sprints.build
    @new_sprint = nil
  end

  def edit
  end

  def create
    @sprint = @project.sprints.build(params[:sprint])
    if @sprint.save
      redirect_to project_sprint_url(@project, @sprint)
    else
      render :action => "new"
    end
  end

  def update
    if @sprint.update_attributes(params[:sprint])
      redirect_to project_sprint_url(@project, @sprint)
    else
      render :action => "edit"
    end
  end

  def destroy
    if !params[:tag].nil?
      @backlog = Backlog.find(params[:tag])
      @backlog.sprint = nil
      @backlog.save
    else
      @sprint.destroy
    end

    respond_to do |format|
      format.html { redirect_to project_sprints_path(@project) }
      format.xml  { head :ok }
    end
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
    @new_project = @project
  end

  def load_sprint
    @sprint = Sprint.find(params[:id])
    @new_sprint = @sprint
  end  
end
