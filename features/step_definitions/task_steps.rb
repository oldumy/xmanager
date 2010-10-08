Given /^a started sprint with a sprint backlog$/ do
  @current_sprint = Factory(:sprint_1)
  @current_sprint_backlog = @current_sprint.sprint_backlogs.create!(:product_backlog => @current_product_backlog)
  @current_sprint.start
end

Then /^I should have a task "([^"]*)"$/ do |name|
  Task.where(:name => name).exists?.should be_true
end

Given /^a task of the product backlog$/ do
  team_member = @current_project.team_members.first
  @current_task = @current_product_backlog.tasks.create!(Factory.attributes_for(:task, :team_member => team_member))
end

Then /^I should not have a task of the product backlog$/ do
  @current_product_backlog.tasks.empty?.should be_true
end
