require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'product_backlogs/edit.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @product_backlog = Factory(:create_product_backlogs)
  end

  it 'should render a form for editing product backlogs' do
    render

    rendered.should have_selector(".form-wrapper>form", :action => project_product_backlog_path(@product_backlog.project, @product_backlog)) do |form|
      form.should have_selector(:input, :name => "product_backlog[name]")
      form.should have_selector(:input, :name => "product_backlog[priority]")
      form.should have_selector(:input, :name => "product_backlog[estimated_story_points]")
      form.should have_selector(:textarea, :name => "product_backlog[description]")
      form.should have_selector(:textarea, :name => "product_backlog[acceptance_criteria]")
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => project_product_backlogs_path(@product_backlog.project))
    end
  end
end
