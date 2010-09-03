# encoding : utf-8
module PaintAssistent

  def gen_sprint_burn_down_data(sprint)
    data = Yeqs::Jquery::Highchart.new('graph') do |f|
      date_arry = sprint_date_parse(sprint.start_time, sprint.end_time)
      task_id_arry = sprint_task_id_data(sprint)

      plan_workload = sprint_workload_data(sprint, date_arry.size)
      finish_workload = sprint_finish_workload_data(task_id_arry, date_arry, sprint_workload_total(sprint))

      f.series('实际', finish_workload)
      f.series('计划', plan_workload)

      f.x_axis({
          :categories => date_arry,
          :labels=>{:rotation=>270 , :align => 'right'}
        })

      f.chart({
          :defaultSeriesType=>"line"
        })

      f.title(:text => '迭代燃尽图')

      f.y_axis({
          :title => {:text => '要完成的工作量'},
          :min => 0
        })
    end
    return data
  end

  def gen_project_burn_down_charts_data(project)
    plan_arry = sprint_story_points_data(project.sprints, :story_points)
    actual_arry = sprint_story_points_data(project.sprints, :actual_story_points)
    total = sprint_story_points_total(plan_arry)

    plan = sprints_story_points_data(plan_arry, total)
    actual = sprints_story_points_data(actual_arry, total)

    data = Yeqs::Jquery::Highchart.new('graph') do |f|

      f.series('实际', actual, :type => 'column')
      f.series('计划', plan, :type => 'line')

      f.title({
          :text => '项目燃尽图',
        })

      x = sprints_name_data(project.sprints)

      f.x_axis({
          :categories => x
        })
      f.y_axis({
          :title => {:text => '要完成的工作量'},
          :min => 0
        })
    end
    return data
  end

  private
# -----------------sprint_burn_down_chart------------------
  def sprint_date_parse(start_time, end_time)
    date_data = []
    current_date = start_time

    while !(current_date === end_time)
      date_data << current_date
      current_date = current_date + 1
    end

    date_data << end_time

    return date_data
  end

  def sprint_workload_data(sprint, average)
    workload_average_data = []
    workload_average = sprint_workload_average(sprint_workload_total(sprint), average)

    average.downto(2){|i| workload_average_data << ((i*workload_average*100).round).to_f/100}

    workload_average_data << 0

    return workload_average_data
  end

  def sprint_workload_total(sprint)
    workload_total = 0
     for task in sprint.tasks
       workload_total += task.workload
     end
    return workload_total
  end

  def sprint_workload_average(total, average)
    workload_average = total / average
    return workload_average
  end

  def sprint_task_id_data(sprint)
    task_id_arry = []
    for backlog in sprint.backlogs
      for task in backlog.tasks
        task_id_arry << task.id
      end
    end
    return task_id_arry
  end

  def sprint_finish_workload_data(task_id_arry, date_arry, total)
    finish_workload_arry = []
    tmp = 0
    for date in date_arry
      for task_id in task_id_arry
        tmp += TaskHistory.where(:task_id => task_id, :date => date).sum(:surplus_workload).to_f
      end

      t = Time.now
      date_now = Date.new(t.year, t.mon, t.mday)

      if (date <=> date_now) != 1
        if tmp == 0
          finish_workload_arry << total
        else
          finish_workload_arry << tmp
        end
      end
      tmp = 0
    end
    return finish_workload_arry
  end

# -----------------project_burn_down_chart------------------
  def sprints_name_data(sprints)
    name_data = []
    name_data << '总量'

    for sprint in sprints
      name_data << '迭代' + sprint.name
    end

    return name_data
  end

  def sprints_story_points_data(arry, total)
    burn_story_points_arry = []

    story_points_arry = arry
    story_points_total = total
    story_points_tmp = 0

    burn_story_points_arry << story_points_total

    story_points_tmp = story_points_total
    for story_points in story_points_arry
      story_points_tmp = (((story_points_tmp - story_points)*100).round).to_f/100
      burn_story_points_arry << story_points_tmp
    end

    return burn_story_points_arry
  end

  def sprint_story_points_data(sprints, arg)
    story_points_arry = []
    for sprint in sprints
      story_points_arry << Backlog.where(:sprint_id => sprint.id).sum(arg).to_f
    end

    return story_points_arry
  end

  def sprint_story_points_total(arry)
    total = 0
    arry.each { |v| total += v }
    return total
  end
end