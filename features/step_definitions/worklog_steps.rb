Given /^a worklog of the task$/ do
  @current_worklog = @current_task.worklogs.create!(:remaining_hours => 2, :description => 'Description of the worklog')
end

Given /^the following worklogs of the task:$/ do |worklogs|
  worklogs.hashes.each do |hash|
    @current_task.worklogs.create!(hash)
  end
end

Then /^I should have a worklog of the task$/ do
  @current_task.worklogs.count.should == 1
end

Then /^I should see the information of the task$/ do
  page.should have_css("h1", :content => @current_task.name)
  page.should have_css("p", :content => @current_task.description)
end

Then /^I should see the two worklogs$/ do
  Worklog.all.each do |worklog|
    page.should have_css("h1", :content => worklog.remaining_hours.to_s)
    page.should have_css("h1>span", :content => worklog.description)
  end
end

Then /^I should not see the worklog$/ do
  page.should_not have_css("h1", :content => @current_worklog.remaining_hours.to_s)
  page.should_not have_css("h1>span", :content => @current_worklog.description)
end

