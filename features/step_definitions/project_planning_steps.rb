Given /^a sprint of the release$/ do
  @current_sprint = Factory(:sprint_1)
end

Then /^I should see a new release button$/ do
  page.should have_css("a[@href=\"#{new_project_release_path(@current_project)}\"]")
end

Then /^I should see the management links of release$/ do
  within("span.actions") do
    page.should have_css("a[@href=\"#{edit_project_release_path(@current_project, @current_release)}\"]")
    page.should have_css("a[@href=\"#{project_release_path(@current_project, @current_release)}\"]")
  end
end

Then /^I should see the management links within the sprint "([^"]*)" head/ do |name|
  @current_sprint = Sprint.find_by_name(name)
  within("#sprint-#{@current_sprint.id}>h1:contains('#{@current_sprint.name}')>span.actions") do
    page.should have_css("a[@href=\"#{new_project_sprint_sprint_backlog_path(@current_project, @current_sprint)}\"]")
    page.should have_css("a[@href=\"#{edit_project_sprint_path(@current_project, @current_sprint)}\"]")
    page.should have_css("a[@href=\"#{project_sprint_path(@current_project, @current_sprint)}\"]")
  end
end

Then /^I should not see the management links within the sprint "([^"]*)" head/ do |name|
  @current_sprint = Sprint.find_by_name(name)
  within("#sprint-#{@current_sprint.id}>h1:contains('#{@current_sprint.name}')") do
    page.should_not have_css("a[@href=\"#{new_project_sprint_sprint_backlog_path(@current_project, @current_sprint)}\"]")
    page.should_not have_css("a[@href=\"#{edit_project_sprint_path(@current_project, @current_sprint)}\"]")
    page.should_not have_css("a[@href=\"#{project_sprint_path(@current_project, @current_sprint)}\"]")
  end
end

Then /^I should not see a new release button$/ do
  page.should_not have_css("a[@href=\"#{new_project_release_path(@current_project)}\"]")
end

Then /^I have (\d+) released releases?$/ do |count|
  @current_project.releases.released.count.should == count.to_i
end

Then /^I should not have any unreleased release$/ do
  @current_project.releases.unreleased.count.should == 0
end

Given /^a sprint backlog of the sprint$/ do
  @current_sprint_backlog = @current_sprint.sprint_backlogs.create!(:product_backlog => @current_product_backlog)
end

Then /^I should not see the management links of the sprint backlog$/ do
    pending # express the regexp above with the code you wish you had
end

