class WorklogsController < ApplicationController
  before_filter :load_task, :except => [:edit, :update, :destroy]
  before_filter :load_worklog, :only => [:edit, :update, :destroy]

  def index
    @worklogs = @task.worklogs
  end

  def new
    @worklog = @task.worklogs.build
  end

  def edit
  end

  def create
    @worklog = @task.worklogs.build(params[:worklog])
    if @worklog.save
      redirect_to on_air_project_sprints_url(@task.product_backlog.project)
    else
      render 'new'
    end
  end

  def update
    if @worklog.update_attributes(params[:worklog])
      redirect_to task_worklogs_url(@worklog.task)
    else
      render 'edit'
    end
  end

  def destroy
    @worklog.destroy
    redirect_to task_worklogs_url(@worklog.task)
  end

  private
  def load_task
    @task = Task.find(params[:task_id])
  end

  def load_worklog
    @worklog = Worklog.find(params[:id])
  end
end
