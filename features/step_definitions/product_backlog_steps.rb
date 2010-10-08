Given /^(\d+|a) product backlogs? named "([^"]*)" of the project$/ do |a, names|
  names.split(/,/).each do |name|
    @current_product_backlog = @current_project.product_backlogs.create!(Factory.attributes_for(name.strip))
  end
end

Given /^a product backlog named "([^"]*)" and add it to the sprint$/ do |name|
  @current_sprint.sprint_backlogs.create!(:product_backlog => Factory(name))
end

When /^I click "([^"]*)" link of the product backlog named "([^"]*)"$/ do |link, name|
  backlog = ProductBacklog.find_by_name(name)
  within(:css, "#product-backlog-#{backlog.id}") do
    click_link link
  end
end

Then /^I should see a product backlog "([^"]*)" (with|without) management links$/ do |name, type|
  @current_product_backlog = ProductBacklog.find_by_name(name)
  @current_product_backlog.should_not be_nil

  within(:css, "#product-backlog-#{@current_product_backlog.id}") do
    page.should have_css("h1", :text => @current_product_backlog.name)
    page.should have_css("h1>span", :text => "Priority(#{@current_product_backlog.priority})")
    page.should have_css("h1>span", :text => "Estimated Story Points(#{@current_product_backlog.estimated_story_points})")
    page.should have_css("p>label", :text => "Description")
    page.should have_css("p", :text => @current_product_backlog.description)
    page.should have_css("p>label", :text => "Acceptance Criteria")
    page.should have_css("p", :text => @current_product_backlog.acceptance_criteria)

    if type == 'with'
      page.should have_css("h1>span.actions>a[@href='#{edit_product_backlog_path(@current_product_backlog)}']", :text => "Edit")
      page.should have_css("h1>span.actions>a[@href='#{product_backlog_path(@current_product_backlog)}']", :text => "Delete")
    end
  end
end
