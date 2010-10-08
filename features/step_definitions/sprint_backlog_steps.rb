Given /^add the following (\d+) product backlogs to the sprint:$/ do |arg1, names|
  names.hashes.each do |hash|
    @current_sprint.sprint_backlogs.create!(:product_backlog => Factory(hash[:name]))
  end
end

Given /^a task of the sprint backlog$/ do
  @current_task = @current_sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:fake_task))
end

Given /^a product backlog of the project$/ do
  @current_product_backlog = Factory(:create_product_backlogs)
end

Given /^a closed sprint backlog of the sprint$/ do
  Given "a done task of the sprint backlog"
  @current_sprint_backlog.product_backlog.close
end

Given /^a done task of the sprint backlog$/ do
  @current_task = @current_product_backlog.tasks.create!(Factory.attributes_for(:task))
  @current_task.worklogs.create!(Factory.attributes_for(:worklog, :remaining_hours => 0))
  @current_task.close
end

# FIXME
Then /^I should not have any unscheduled product backlog$/ do
  @current_project.product_backlogs.unscheduled.empty?.should be_true
end

Then /^I should have (\d+) backlogs? in the sprint$/ do |count|
  @current_sprint.sprint_backlogs.count.should == count.to_i
end

Given /^a backlog of the sprint$/ do
  @current_sprint_backlog = SprintBacklog.create!(:sprint => @current_sprint, :product_backlog => @current_product_backlog)
end

Then /^I should not have a backlog in the sprint$/ do
  @current_sprint.sprint_backlogs.empty?.should be_true
end

Then /^I should have (\d+) unscheduled product backlogs? in the project$/ do |count|
  @current_project.product_backlogs.unscheduled.count.should == count.to_i
end

