# encoding: utf-8
module ApplicationHelper
  
  def generate_ul

    regx_role = /^\/projects\/\d+\/project_roles/
    regx_sprint = /^\/projects\/\d+\/sprints(\/(new|\d+\/edit|\d+))*$/
    regx_sprint_task = /^\/projects\/\d+\/sprints\/\d+\/tasks/
    regx_backlog = /^\/projects\/\d+\/backlogs/
    regx_project_task = /^\/projects\/\d+\/tasks/
    unless @project.nil?||@new_project.nil?
      content_tag(:h1,content_tag(:a,@project.name,:href=>"/projects/#{@project.id}"))+
        content_tag(:div,:id=>"main-menu") do
        out=""
        if request.path =~ regx_role
          out += content_tag(:li){link_to '角色', project_project_roles_path(@project),:class=>"selected"}
        else
          out += content_tag(:li){link_to '角色', project_project_roles_path(@project)}
        end

        if request.path =~ regx_sprint||request.path =~ regx_sprint_task
          out += content_tag(:li){link_to '迭代管理', project_sprints_path(@project),:class=>"selected"}
        else
          out += content_tag(:li){link_to '迭代管理', project_sprints_path(@project)}
        end

        if request.path =~ regx_backlog
          out += content_tag(:li){link_to '待办事项', project_backlogs_path(@project),:class=>"selected"}
        else
          out += content_tag(:li){link_to '待办事项', project_backlogs_path(@project)}
        end

        if request.path =~ regx_project_task
          out += content_tag(:li){link_to '项目任务列表', project_tasks_path(@project),:class=>"selected"}
        else
          out += content_tag(:li){link_to '项目任务列表', project_tasks_path(@project)}
        end

        out
        content_tag(:ul) do
          out
        end
      end
    else
      content_tag(:h1,content_tag(:a,"xmanager",:href=>"/"))
    end
  end
end
