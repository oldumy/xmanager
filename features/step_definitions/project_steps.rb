Given /^I have a project$/ do
  @current_project = Factory(:xmanager)
end

Given /^the following projects:$/ do |projects|
  projects.hashes.each do |project| 
    creater = User.find_by_login(project[:creater]) || Factory(project[:creater])
    Project.create!(:name => project[:name], :description => project[:description], :creater => creater)
  end
end

Given /^I am a team member of "([^"]*)"$/ do |project_name|
  @current_project = Project.find_by_name(project_name)
  @current_project.team_members.create!(:user => @current_user)
end

Given /^I have a project which factory name is "([^"]*)"$/ do |factory_name|
  @current_project = Factory(factory_name, :creater => @current_user)
end

Given /^a project which factory name is "([^"]*)"$/ do |factory_name|
  @current_project = Factory(factory_name)
end

Given /^I am a team member of the project$/ do
  @current_project.team_members.create!(:user => @current_user)
end

Given /^a project with (a|\d+) team members? "([^"]*)"$/ do |arg1, members|
  @current_project = Factory(:xmanager)
  members.split(/,/).each do |member|
    user = User.find_by_login(member.strip) || Factory(member.strip)
    @current_project.team_members.create!(:user => user)
  end
end

When /^I click "([^"]*)" within the project "([^"]*)"$/ do |link, name|
  project = Project.find_by_name(name)
  within("#project-#{project.id}>h1>span.actions") do
    click_link link
  end
end

Then /^I should see the project "([^"]*)" (with|without) management links$/ do |name, type|
  project = Project.find_by_name(name)
  within("#project-#{project.id}") do
    page.should have_css("h1>a[@href='#{on_air_project_sprints_path(project)}']", :text => project.name)
    page.should have_css("p", :text => project.description)

    if type == "with"
      # management links: edit, delete
      page.should have_css("h1>span.actions>a[@href='#{edit_project_path(project)}']", :text => "Edit")
      page.should have_css("h1>span.actions>a[@href='#{project_path(project)}']", :text => "Delete")
    end
  end
end

Then /^I should see a new project button$/ do
  page.should have_css("a[@href='#{new_project_path}']", :text => "New")
end

Then /^I should have a project named "([^"]*)"$/ do |name|
  Project.where(:name => name).exists?.should be_true
end

