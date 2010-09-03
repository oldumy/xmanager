# encoding : utf-8
class ProjectBurnDownChartsController < ApplicationController
  include PaintAssistent
  filter_access_to :all
  def index
    @project = Project.find(params[:project_id])
    @new_project = @project
    @h = gen_project_burn_down_charts_data(@project)
  end
end