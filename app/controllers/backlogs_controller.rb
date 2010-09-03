# encoding: utf-8
class BacklogsController < ApplicationController
  filter_access_to :all
  before_filter :load_project
  # GET /backlogs
  # GET /backlogs.xml
  def index
    backlogs = @project.backlogs.nil? ? []:@project.backlogs
    @backlogs = backlogs.paginate :page => params[:page] || 1, :per_page => I18n.t("pagination.per_page")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @backlogs }
    end
  end

  # GET /backlogs/1
  # GET /backlogs/1.xml
  def show
    @backlog = Backlog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @backlog }
    end
  end

  # GET /backlogs/new
  # GET /backlogs/new.xml
  def new
    @backlog = Backlog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @backlog }
    end
  end

  # GET /backlogs/1/edit
  def edit
    @backlog = Backlog.find(params[:id])
  end

  # POST /backlogs
  # POST /backlogs.xml
  def create
    if params[:commit] == '指定迭代'
      unless params[:backlogs].nil? || params[:sprint_id].nil?
        update_sprint
      end
      redirect_to project_backlogs_path
    else
      @backlog = Backlog.new(params[:backlog])
      @backlog.project = @project
      respond_to do |format|
        if @backlog.save
          format.html { redirect_to(project_backlog_path(@project.id,@backlog.id), :notice => '待办事项添加成功.') }
          format.xml  { render :xml => @backlog, :status => :created, :location => @backlog }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @backlog.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /backlogs/1
  # PUT /backlogs/1.xml
  def update
    @backlog = Backlog.find(params[:id])

    respond_to do |format|
      if @backlog.update_attributes(params[:backlog])
        format.html { redirect_to(project_backlog_path(@project.id,@backlog.id), :notice => '待办事项已更新.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @backlog.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /backlogs/1
  # DELETE /backlogs/1.xml
  def destroy
    @backlog = Backlog.find(params[:id])
    @backlog.destroy

    respond_to do |format|
      format.html { redirect_to(project_backlogs_path) }
      format.xml  { head :ok }
    end
  end

  private
  def load_project
    @project = Project.find(params[:project_id])
    @new_project = @project
  end

  def update_sprint
    select_backlogs = Backlog.find(params[:backlogs])
    sprint = Sprint.find(params[:sprint_id])
    sprint.backlogs << select_backlogs
  end
end
