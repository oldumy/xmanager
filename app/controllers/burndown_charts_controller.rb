class BurndownChartsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    if @project.started?
      on_air_sprint = @project.sprints.on_air
      release = on_air_sprint.release
      story_points = [release.story_points.to_i]
      x_axis_categories = []
      release.sprints.each do |sprint|
        story_points << (story_points.last - sprint.story_points).to_i
        x_axis_categories << sprint.name
      end
      x_axis_categories << ' '
      @project_chart = Yeqs::Jquery::Highchart.new('graph') do |f|
        f.options[:title][:text] = t("titles.project_burndown_chart")
        f.options[:chart][:defaultSeriesType] = "column"
        f.options[:chart][:width] = 1000
        f.options[:x_axis][:categories] = x_axis_categories
        f.options[:y_axis][:title][:text] = ' '
        f.series(t("labels.story_points"), story_points)
        f.html_options[:class] = 'highcharts'
      end

      remaining_hours = []
      end_day = Time.now < on_air_sprint.estimated_closed_on ? Time.now : on_air_sprint.estimated_closed_on
      (on_air_sprint.estimated_started_on..end_day.to_date).each do |day|
        remaining_hours << on_air_sprint.remaining_hours
      end
      @sprint_chart = Yeqs::Jquery::Highchart.new('graph') do |f|
        f.options[:title][:text] = t("titles.sprint_burndown_chart")
        f.options[:chart][:defaultSeriesType] = "line"
        f.options[:chart][:width] = 1000
        f.options[:x_axis][:categories] = on_air_sprint.estimated_started_on..on_air_sprint.estimated_closed_on
        f.options[:y_axis][:title][:text] = ' '
        f.series(t("labels.ideal_burndown"), [[0, on_air_sprint.estimated_hours.to_i], [remaining_hours.count - 1, 0]])
        f.series(t("labels.real_burndown"), remaining_hours)
        f.html_options[:class] = 'highcharts'
      end
    else
      flash[:notice] = t("notices.project_not_started")
    end
  end
end
