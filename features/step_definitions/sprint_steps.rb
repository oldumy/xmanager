Given /^the following sprints of the release:$/ do |sprints|
  sprints.hashes.each do |hash|
    sprint = @current_release.sprints.create!(:name => hash[:name], :estimated_started_on => hash[:estimated_started_on], :estimated_closed_on => hash[:estimated_closed_on], :description => hash[:description])
    if hash[:has_sprint_backlog].include?('true')
      sprint_backlog = sprint.sprint_backlogs.create!(:product_backlog => Factory(:fake_product_backlog, :project => @current_release.project))
      if hash[:closable] && hash[:closable].include?('true')
        task = sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:fake_task))
        task.worklogs.create!(:remaining_hours => 0)
        task.close
        sprint_backlog.product_backlog.close 
      end
    end
    if hash[:closed].include?('true')
      sprint.start
      sprint.close
    end
    sprint.start if hash[:on_air].include?('true')
  end
end

When /^I click "([^"]*)" within the management links of "([^"]*)"$/ do |link, sprint_name|
  sprint = @current_release.sprints.find_by_name(sprint_name)
  within("#sprint-#{sprint.id}>h1>span.actions") do
    click_link link
  end
end

Then /^I should see the sprint "([^"]*)"$/ do |sprint_name|
  sprint = @current_release.sprints.find_by_name(sprint_name)
  within("#sprint-#{sprint.id}") do
    page.should have_css("h1", :text => sprint.name)
    page.should have_css("h1>span", :text => sprint.description)
    if sprint.closed?
      page.should have_css("h1>span.red", :text => "#{sprint.started_on}..#{sprint.closed_on}")
      page.should have_css("h1>span.deleted", :text => "#{sprint.estimated_started_on}..#{sprint.estimated_closed_on}")
    else
      page.should have_css("h1>span.red", :text => "#{sprint.estimated_started_on}..#{sprint.estimated_closed_on}")
    end
  end
end

Then /^I should see "([^"]*)" within the management links of "([^"]*)"$/ do |text, sprint_name|
  sprint = @current_release.sprints.find_by_name(sprint_name)
  within("#sprint-#{sprint.id}>h1>span.actions") do
    page.should have_css("a", :text => text)
  end
end

Then /^I should not see "([^"]*)" within the management links of "([^"]*)"$/ do |text, sprint_name|
  sprint = @current_release.sprints.find_by_name(sprint_name)
  within("#sprint-#{sprint.id}>h1>span.actions") do
    page.should_not have_css("a", :text => text)
  end
end

Then /^I should see the sprint backlog "([^"]*)" with management links$/ do |name|
  @current_sprint_backlog = SprintBacklog.joins(:product_backlog).where("product_backlogs.name=?", name).first
  @current_sprint_backlog.should_not be_nil

  within("#sprint-backlog-#{@current_sprint_backlog.id}") do
    page.should have_css("h1", :text => @current_sprint_backlog.product_backlog.name)
    page.should have_css("h1>span", :text => "Priority(#{@current_sprint_backlog.product_backlog.priority})")
    page.should have_css("h1>span", :text => "Estimated Story Points(#{@current_sprint_backlog.product_backlog.estimated_story_points})")
    page.should have_css("h1>span.actions>a[@href='#{new_product_backlog_task_path(@current_sprint_backlog.product_backlog)}']", :text => "New Task")
    page.should have_css("h1>span.actions>a[@href='#{close_product_backlog_path(@current_sprint_backlog.product_backlog)}']", :text => "Close")
    page.should have_css("p>label", :text => "Description")
    page.should have_css("p", :text => @current_sprint_backlog.product_backlog.description)
    page.should have_css("p>label", :text => "Acceptance Criteria")
    page.should have_css("p", :text => @current_sprint_backlog.product_backlog.acceptance_criteria)
  end
end

# FIXME
Given /^(\d+) sprints? named "([^"]*)" of the release$/ do |a, names|
  names.split(/,/).each do |name|
    Factory(name.strip)
  end
end

Given /^a started sprint of the release$/ do
  @current_sprint = Factory(:sprint_1, :release => @current_release)
  @current_product_backlog = Factory(:create_product_backlogs)
  @current_sprint_backlog = @current_sprint.sprint_backlogs.create!(:product_backlog => @current_product_backlog)
  @current_sprint.start
end

When /^I click "([^"]*)" within the sprint "([^"]*)"$/ do |link, name|
  @current_sprint = Sprint.find_by_name(name)
  within("#sprint-#{@current_sprint.id}>h1>span.actions") do
    click_link link
  end
end

Then /^I should not have a sprint named "([^"]*)"$/ do |name|
  Sprint.where(:name => name).exists?.should be_false
end

Then /^I should have a sprint named "([^"]*)"$/ do |name|
  Sprint.where(:name => name).exists?.should be_true
end

Then /^I should have started "([^"]*)"$/ do |name|
  Sprint.find_by_name(name).started?.should be_true
end

Then /^I should not have started "([^"]*)"$/ do |name|
  Sprint.find_by_name(name).started?.should be_false
end

Then /^I should see "([^"]*)" within the sprint "([^"]*)"$/ do |text, name|
  sprint = Sprint.find_by_name(name)
  within("#sprint-#{sprint.id}>h1>span.actions") do
    page.should have_content(text)
  end
end

Then /^I should be noticed no record found$/ do
  page.should have_css("#no-record-found")
end

Given /^I started the sprint "([^"]*)"$/ do |name|
  @current_sprint = Sprint.find_by_name(name)
  @current_sprint.start
end

Given /^a closed sprint of the project$/ do
  @current_sprint = Factory(:sprint_1)
  @current_sprint.start
  @current_sprint.close
end

Then /^I should have reopened "([^"]*)"$/ do |name|
  @current_sprint = Sprint.find_by_name(name)
  @current_sprint.on_air?.should be_true
end

