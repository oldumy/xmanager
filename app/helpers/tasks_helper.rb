# encoding: utf-8
module TasksHelper
  def link_for_update_progress(task)
    link_body = '登记工时'

    if task.workload.blank? || @current_user != task.user
      link_body
    else
      url = @sprint.blank?? edit_project_task_path(@project, task):edit_project_sprint_task_path(@project, @sprint, task)
      link_to(link_body, url)
    end
  end
end

