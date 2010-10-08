class ProductBacklogsController < ApplicationController
  before_filter :load_project, :except => [:edit, :update, :destroy, :close, :reopen]
  before_filter :load_product_backlog, :only => [:edit, :update, :destroy, :close, :reopen]

  def index
    @product_backlogs = @project.product_backlogs.unscheduled
    @product_backlogs = @product_backlogs.paginate(:page => params[:page])
  end

  def new
    @product_backlog = @project.product_backlogs.build
  end

  def edit
  end

  def create
    @product_backlog = @project.product_backlogs.build(params[:product_backlog])
    if @product_backlog.save
      redirect_to project_product_backlogs_url(@project)
    else
      render :action => 'new'
    end
  end

  def update
    if @product_backlog.update_attributes(params[:product_backlog])
      redirect_to project_product_backlogs_url(@product_backlog.project)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @product_backlog.destroy
    redirect_to project_product_backlogs_url(@product_backlog.project)
  end

  def close
    flash[:notice] = t("notices.product_backlog_not_closed") unless @product_backlog.close
    redirect_to on_air_project_sprints_url(@product_backlog.project)
  end

  def reopen
    @product_backlog.reopen
    redirect_to on_air_project_sprints_url(@product_backlog.project)
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_product_backlog
    @product_backlog = ProductBacklog.find(params[:id])
  end

end
