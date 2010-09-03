# encoding: utf-8
class ProjectRolesController < ApplicationController
  filter_access_to :all
  before_filter :get_project
  # GET /project_roles
  # GET /project_roles.xml
  def index
    @project_roles = @project.project_roles
  end

  # GET /project_roles/1
  # GET /project_roles/1.xml
  def show
    @project_role = @project.project_roles.find(params[:id])
  end

  # GET /project_roles/new
  # GET /project_roles/new.xml
  def new
    @project_role = ProjectRole.new
  end

  # GET /project_roles/1/edit
  def edit
    @project_role = ProjectRole.find(params[:id])
    @project_role.project = @project
  end

  # POST /project_roles
  # POST /project_roles.xml
  def create
    @project_role = ProjectRole.new(params[:project_role])
    @project_role.project = @project

    if @project_role.save
      redirect_to project_project_role_url(@project, @project_role),:notice=>"创建项目角色成功."
    else
      render :action => "new"
    end
  end

  # PUT /project_roles/1
  # PUT /project_roles/1.xml
  def update
    @project_role = ProjectRole.find(params[:id])

    if @project_role.update_attributes(params[:project_role])
      redirect_to project_project_role_url(@project, @project_role),:notice=>"更新项目角色成功."
    else
      render :action => "edit"
    end
  end

  # DELETE /project_roles/1
  # DELETE /project_roles/1.xml
  def destroy
    
    @project_role = ProjectRole.find(params[:id])
    @project_role.destroy

    respond_to do |format|
      format.html { redirect_to project_project_roles_path(@project) }
      format.xml  { head :ok }
    end
  end

  private 
  def get_project
    @project = Project.find(params[:project_id])
    @new_project = @project
  end
end
