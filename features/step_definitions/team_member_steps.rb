Given /^I have a list of people$/ do
  Factory(:tower)
  Factory(:venus)
  Factory(:yanny)
  Factory(:jessimine)
end

Given /^I have \d+ team members? (.*)$/ do |members|
  members.split(/,/).each do |member|
    @current_project.team_members.create!(:user => User.find_by_login(member.strip))
  end
end

When /^I check "([^"]*)" in the candidates$/ do |candidate|
  within(:css, "form#candidates-form") do
    check candidate
  end
end

When /^I click "([^"]*)" in the team members$/ do |member|
  within(:css, "div#team-members") do
    click_link member
  end
end

Then /^I should not see any team member$/ do
  page.should_not have_css("div#team-members")
end

Then /^I should see a list of candidates$/ do
  page.should have_css("div#candidates form")
  page.should have_content("Tower He")
  page.should have_content("Venus")
  page.should have_content("Yanny Yang")
  page.should have_content("Jessimine Tang")
  page.should have_content("Online Dummy")
end

Then /^I should see (.*) in team members?$/ do |members|
  members.split(/,/).each do |member|
    within(:css, "div#team-members") do
      page.should have_content(User.find_by_login(member.strip).name)
    end
  end
end

Then /^I should not see (.*) in candidates$/ do |candidates|
  candidates.split(/,/).each do |candidate|
    within(:css, "form#candidates-form") do
      page.should_not have_content(User.find_by_login(candidate.strip).name)
    end
  end
end

Then /^I should not see (.*) in team members?$/ do |members|
  members.split(/,/).each do |member|
    within(:css, "div#team-members") do
      page.should_not have_content(User.find_by_login(member.strip).name)
    end
  end
end

Then /^I should see (.*) in candidates$/ do |candidates|
  candidates.split(/,/).each do |candidate|
    within(:css, "form#candidates-form") do
      page.should have_content(User.find_by_login(candidate.strip).name)
    end
  end
end


