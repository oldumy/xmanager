module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /the home\s?page/
      '/'
    when /the new project page/
      new_project_path
    when /the edit project page/
      edit_project_path(@current_project)
    when /the new sprint page of the project/
      new_release_sprint_path(@current_release)
    when /the new sprint backlog page/
      new_sprint_sprint_backlog_path(@current_sprint)

    when /the list of projects/
      projects_path
    when /the team members page of the project/
      project_team_members_path(@current_project)
    when /the sprints page of the project/
      project_sprints_path(@project)
    when /the new product backlog page/
      new_project_product_backlog_path(@current_project)
    when /the edit product backlog page/
      edit_project_product_backlog_path(@current_project, @current_product_backlog)
    when /the product backlogs page/
      project_product_backlogs_path(@current_project)
    when /the new release page/
      new_project_release_path(@current_project)
    when /the edit release page/
      edit_project_release_path(@current_project, @current_release)
    when /the project plannings page of the project/
      project_project_plannings_path(@current_project)
    when /the edit sprint page of the project/
      edit_project_sprint_path(@current_project, @current_sprint)
    when /the on air sprint page/
      on_air_project_sprints_path(@current_project)
    when /the new task page/
      new_product_backlog_task_path(@current_product_backlog)
    when /the edit task page/
      edit_product_backlog_task_path(@current_product_backlog, @current_task)
    when /the new worklog page of the task/
      new_task_worklog_path(@current_task)
    when /the edit worklog page/
      edit_task_worklog_path(@current_task, @current_worklog)
    when /the worklogs page/
      task_worklogs_path(@current_task)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
