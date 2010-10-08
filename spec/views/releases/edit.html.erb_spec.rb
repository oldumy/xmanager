require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'releases/edit.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @release = Factory(:v_1)
  end

  it 'should render a form to edit the release' do
    render

    rendered.should have_selector(".form-wrapper>form", :action => project_release_path(@release.project, @release)) do |form|
      form.should have_selector(:input, :name => "release[name]", :value => @release.name)
      form.should have_selector(:textarea, :name => "release[description]", :content => @release.description)
      form.should have_selector(:input, :name => "release[estimated_released_on]", :value => @release.estimated_released_on.to_s)
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => project_project_plannings_path(@release.project))
    end
  end
end
