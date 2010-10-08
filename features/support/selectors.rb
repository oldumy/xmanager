module HtmlSelectorsHelper
  def selector_for(scope)
    case scope
    when /the notices/
      "#notices"
    when /the new project form/
      ".form-wrapper>form[@action='#{projects_path}']"
    when /the list of projects/
      "#projects"
    when /the edit project form/
      ".form-wrapper>form[@action='#{project_path(@current_project)}']"
    when /the management links of sprint/
      "#sprint-#{@current_sprint.id}>h1>span.actions"
    when /the head of sprint/
      "#sprint-#{@current_sprint.id}>h1"
    when /the list of sprint backlogs/
      ".sprint-backlogs"
    # product backlogs
    when /the list of product backlogs/
      "#product-backlogs"
    when /the new product backlog form/
      ".form-wrapper>form[@action='#{project_product_backlogs_path(@current_project)}']"
    when /the edit product backlog form/
      ".form-wrapper>form[@action='#{project_product_backlog_path(@current_project, @current_product_backlog)}']"
    # releases
    when /the list of releases/
      "#releases"
    when /the list of released releases/
      "#released-releases"
    when /the new release form/
      ".form-wrapper>form[@action='#{project_releases_path(@current_project)}']"
    when /the edit release form/
      ".form-wrapper>form[@action='#{project_release_path(@current_release.project, @current_release)}']"
    # sprints
    when /the sprint list of the release/
      "#release-#{@current_release.id}>div.sprints"
    when /the new sprint form/
      ".form-wrapper>form[@action='#{release_sprints_path(@current_release)}']"
    when /the edit sprint form/
      ".form-wrapper>form[@action='#{release_sprint_path(@current_release, @current_sprint)}']"
    # worklogs
    when /the new worklog form/
      ".form-wrapper>form[@action='#{task_worklogs_path(@current_task)}']"
    when /the edit worklog form/
      ".form-wrapper>form[@action='#{task_worklog_path(@current_task, @current_worklog)}']"
    when /the worklog list/
      ".worklogs"


    when /the body/
      "html > body"
    when /the bottom buttons/
      "#bottom-buttons"
    when /the release head/
      "#release-#{@current_release.id} > h1"
    when /the sprint head/
      "#sprint-#{@current_sprint.id} > h1"
    when /the sprint form/
      ".form-wrapper > form"
    when /the add product backlogs form/
      ".form-wrapper > form"
    when /the sprint backlog head/
      "#sprint-backlog-#{@current_sprint_backlog.id} > h1"
    when /the new task form/
      ".form-wrapper > form[@id='new_task']"
    when /the edit task form/
      ".form-wrapper > form"
    when /the worklog form/
      ".form-wrapper > form"
    when /the task panel/
      "#task-panel"
    when /the task head/
      "#task-#{@current_task.id} > h1"
    else
      raise "Can't find mapping from \"#{scope}\" to a selector.\n" +
            "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelper)
