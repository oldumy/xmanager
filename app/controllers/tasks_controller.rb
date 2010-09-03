# encoding: utf-8
class TasksController < ApplicationController
  filter_access_to :all
  before_filter :load_developers, :except => [:index, :show, :destroy]
  before_filter :load_project, :load_sprint

  MASTERS = ['product_owners', 'scrum_masters']
  # GET /tasks
  # GET /tasks.xml
  def index
    unless params[:sprint_id].blank?
      @tasks = @sprint.tasks.paginate :page => params[:page], :per_page => I18n.t("pagination.per_page")
      render :action => :sprint_tasks
    else
      @sprints = @project.sprints
      role_name = @current_user.role.role_name
      if MASTERS.include?(role_name)
        @tasks = @project.tasks.paginate :page => params[:page], :per_page => I18n.t("pagination.per_page")
        @is_master = true
      else
        @tasks = @project.tasks.where('tasks.user_id=?', @current_user.id).paginate :page => params[:page], :per_page => I18n.t("pagination.per_page")
      end
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @sprints = @project.sprints
    @task = Task.find(params[:id])
    unless params[:edit].blank?
      render :action => :edit_task
    else
      render :action => :update_progress
    end
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    if params[:prj_task_list]
      params[:tasks] ||= []
      params[:tasks].each do |task_id|
        Task.find(task_id).update_attribute(:sprint_id, params[:task][:sprint_id])
      end
      redirect_to(project_tasks_url(@project))
    else
      req_params = params[:task].merge({
          :surplus_workload => params[:task][:workload],
          :progress => 0,
          :project => @project
        })
      @task = Task.new(req_params)

      if @task.save
        redirect_to(project_task_url(@project, @task), :notice => '新建任务成功')
      else
        @task.errors.delete(:surplus_workload)
        render :action => :new
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    unless params[:sprint_id].blank?
      url = project_sprint_tasks_url(@project, @task.sprint)
    else
      url = project_tasks_url(@project)
    end

    if params[:edit].blank?
      task_attrs = params[:task]
      if @task.update_task_progress(task_attrs)
        redirect_to(url)
      else
        render :action => :update_progress
      end
    else
      params[:task].merge!(:surplus_workload => params[:task][:workload])
      if @task.update_attributes(params[:task])
        redirect_to(url)
      else
        render :action => :edit_task
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    unless params[:sprint_id].blank?
      @task.sprint = nil
      @task.save
      redirect_to(project_sprint_tasks_url(@project, @sprint))
    else
      @task.destroy
      redirect_to(project_tasks_url(@project))
    end
  end

  private

  def load_project
    @project = Project.find(params[:project_id])
    @new_project =  @project
  end

  def load_sprint
    begin
      @sprint = Sprint.find(params[:sprint_id])
    rescue
    end
  end

  def load_developers
    @developers = User.joins(:role).where("roles.role_name='developers'")
  end
end
