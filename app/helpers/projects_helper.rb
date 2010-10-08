module ProjectsHelper
  def magic_project_path(project)
    if project.team_members.empty?
      project_team_members_path(project)
    else
      project_project_plannings_path(project)
    end
  end
end
