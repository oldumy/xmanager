class TasksController < ApplicationController
  before_filter :load_product_backlog, :only => [:new, :create]
  before_filter :load_task, :except => [:new, :create]
  before_filter :assign_project

  def new
    @task = @product_backlog.tasks.build
  end

  def edit
  end

  def create
    @task = @product_backlog.tasks.build(params[:task])
    if @task.save
      redirect_to on_air_project_sprints_url(@project)
    else
      render 'new'
    end
  end

  def update
    if @task.update_attributes(params[:task])
      redirect_to on_air_project_sprints_url(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to on_air_project_sprints_url(@project)
  end

  def close
    @task.close
    redirect_to on_air_project_sprints_url(@project)
  end

  def reopen
    @task.reopen
    redirect_to on_air_project_sprints_url(@project)
  end

  private
  def load_product_backlog
    @product_backlog = ProductBacklog.find(params[:product_backlog_id])
  end

  def load_task
    @task = Task.find(params[:id])
  end

  def assign_project
    @project = @product_backlog.project if @product_backlog
    @project = @task.product_backlog.project if @task
  end

end
