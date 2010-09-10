Given /^I have a project named (.+)$/ do |name|
  @project = Project.create!(:name => name)
end

Given /^the following projects:$/ do |projects|
  Project.create!(projects.hashes)
end

When /^I delete the project named (.+)$/ do |name|
  project = Project.find_by_name!(name)
  visit projects_path
  within(:css, "div#project-mgt-#{project.id}") do
    click_link "Delete"
  end
end

Then /^I should see "([^"]*)" and "([^"]*)"$/ do |arg1, arg2|
  page.should have_content(arg1)
  page.should have_content(arg2)
end

Then /^I should not see "([^"]*)" and "([^"]*)"$/ do |arg1, arg2|
  page.should_not have_content(arg1)
  page.should_not have_content(arg2)
end

Then /^I should have (\d+) projects? named "([^"]*)"$/ do |count, project_name|
  Project.where(:name => project_name).count.should == count.to_i
end

Then /^I should see the following projects:$/ do |projects|
  projects.hashes.each do |hash|
    page.should have_content(hash[:name])
    page.should have_content(hash[:description])
  end
end
