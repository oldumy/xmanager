# encoding : utf-8
class SprintBurnDownChartsController < ApplicationController
  include PaintAssistent
  filter_access_to :all
  def index
    @new_sprint = @sprint = Sprint.find(params[:sprint_id])
    @project = @sprint.project
    @new_project = @project
    @data = gen_sprint_burn_down_data(@sprint)
  end
end