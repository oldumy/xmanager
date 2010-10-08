require File.dirname(__FILE__) + '/../view_spec_helper'

describe 'sprint_backlogs/new.html.erb' do
  before(:each) do
    current_user(:oldumy)
    @sprint = Factory(:sprint_1)
  end

  it 'should render backlog selection form' do
    product_backlogs = [Factory(:create_product_backlogs), Factory(:list_product_backlogs)]
    @sprint.release.project.product_backlogs.should_receive(:unscheduled).twice.and_return(product_backlogs)
    render
    
    rendered.should have_selector(".form-wrapper>form", :action => sprint_sprint_backlogs_path(@sprint)) do |form|
      form.should have_selector(:input, :type => 'checkbox', :name => 'backlogs[]', :value => product_backlogs[0].id.to_s)
      form.should have_selector(:input, :type => 'checkbox', :name => 'backlogs[]', :value => product_backlogs[1].id.to_s)
      form.should have_selector(:button, :type => 'submit')
      form.should have_selector(:a, :href => project_project_plannings_path(@sprint.release.project))
    end
  end

  it 'should notice no product backlog found' do
    @sprint.release.project.product_backlogs.stub_chain(:unscheduled, :empty?).and_return(true)
    render

    rendered.should have_selector("#no-record-found")
  end
end
