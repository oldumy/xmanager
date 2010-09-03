# encoding: utf-8

module BacklogsHelper
  def roles_for_project
    Project.where(:id => @project.id).first.project_roles
  end
  
  def name_for_sprint
    @project.sprints
  end

  def desc(backlog)
    role = backlog.project_role
    role ||= ""
    what = "我可以：#{backlog.what}"

    if !role.blank?
      role = role.role_name
      "作为#{role}，" + what
    else
      what
    end
  end

  def status_select
    html = ""
    if @backlog.status == 0
      html << "<select name='backlog[status]'>
      <option value=0 selected='selected'>未完成</option>
      <option value=1>已完成</option>
    </select>"
    else
      html << "<select name='backlog[status]'>
      <option value=0>未完成</option>
      <option value=1  selected='selected'>已完成</option>
    </select>"
    end
    html.html_safe
  end
end
