require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'releases/new.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @release = Release.new(:project => Factory(:xmanager))
  end

  it 'should render a form to create a release' do
    render

    rendered.should have_selector(".form-wrapper>form", :action => project_releases_path(@release.project)) do |form|
      form.should have_selector(:input, :name => "release[name]")
      form.should have_selector(:textarea, :name => "release[description]")
      form.should have_selector(:input, :name => "release[estimated_released_on]")
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => project_project_plannings_path(@release.project))
    end
  end
end
