Given /^the following (released |)releases of the project:$/ do |type, releases|
  releases.hashes.each do |hash|
    release = @current_project.releases.create!(hash)
    sprint = release.sprints.create!(Factory.attributes_for(:sprint_1, :release => release))
    product_backlog = @current_project.product_backlogs.create!(Factory.attributes_for(:fake_product_backlog))
    sprint_backlog = sprint.sprint_backlogs.create!(Factory.attributes_for(:sprint_backlog, :product_backlog => product_backlog, :sprint => sprint))
    task = sprint_backlog.product_backlog.tasks.create!(Factory.attributes_for(:fake_task))
    sprint.start

    task.worklogs.create!(:remaining_hours => 0)
    task.close
    sprint_backlog.product_backlog.close
    sprint.close
    if type.include?('released')
      release.release
    end
  end
end

Given /^a release of the project$/ do
  @current_release = Factory(:v_1, :project => @current_project)
end

Given /^(\d+) releases named "([^"]*)" of the project$/ do |a, names|
  names.split(/,/).each do |name|
    Factory(name.strip)
  end
end

Given /^a release "([^"]*)" of the project$/ do |arg1|
  @current_release = @current_project.releases.create!(Factory.attributes_for(:v_1))
end

Given /^a not closed sprint of the release$/ do
  @current_sprint = @current_release.sprints.create!(Factory.attributes_for(:sprint_1))
end

When /^I click "([^"]*)" within the release "([^"]*)"$/ do |link, name|
  within("h1:contains('#{name}')>span.actions") do
    click_link link
  end
end

Then /^I should see the (released |)release "([^"]*)" with management links$/ do |type, name|
  @current_release = @current_project.releases.find_by_name(name)
  within("#release-#{@current_release.id}") do
    page.should have_css("h1", :text => @current_release.name)
    page.should have_css("h1>span", :text => @current_release.description)

    unless type.include?('released')
      page.should have_css("h1>span.red", :text => @current_release.estimated_released_on.to_s)
      page.should have_css("h1>span.actions>a[@href='#{release_release_path(@current_release)}']", :text => "Release") 
      page.should have_css("h1>span.actions>a[@href='#{new_release_sprint_path(@current_release)}']", :text => "New Sprint") 
      page.should have_css("h1>span.actions>a[@href='#{edit_release_path(@current_release)}']", :text => "Edit") 
      page.should have_css("h1>span.actions>a[@href='#{release_path(@current_release)}']", :text => "Delete") 
    else
      page.should have_css("h1>span.deleted", :text => @current_release.estimated_released_on.to_s)
      page.should have_css("h1>span.red", :text => @current_release.released_on.to_s)
      page.should have_css("h1>span.actions>a[@href='#{turnback_release_path(@current_release)}']", :text => "Turn Back") 
    end
  end
end

Then /^I should not have a release named "([^"]*)"$/ do |name|
  Release.where(:name => name).exists?.should be_false
end

Then /^I should have a release named "([^"]*)"$/ do |name|
  Release.where(:name => name).exists?.should be_true
end

Given /^a released release of the project$/ do
  @current_release = Factory(:v_1)
  @current_release.release
end

Then /^I have (\d+) unreleased release$/ do |count|
  Release.unreleased.count.should == count.to_i
end

Then /^I should not have any released release$/ do
  Release.released.count.should == 0
end

