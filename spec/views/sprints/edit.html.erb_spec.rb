require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'sprints/edit.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @sprint = Factory(:sprint_1)
  end

  it 'should render new sprint form' do
    render
    
    rendered.should have_selector(".form-wrapper>form", :action => release_sprint_path(@sprint.release, @sprint)) do |form|
      form.should have_selector(:input, :name => "sprint[name]")
      form.should have_selector(:textarea, :name => "sprint[description]")
      form.should have_selector(:input, :name => "sprint[estimated_started_on]")
      form.should have_selector(:input, :name => "sprint[estimated_closed_on]")
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => project_project_plannings_path(@sprint.release.project))
    end
  end
end
