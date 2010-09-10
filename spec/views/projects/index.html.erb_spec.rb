require 'spec_helper'

describe 'projects/index.html.erb' do
  it "should have a no record found div" do
    current_user(:developer)
    @projects = []
    render

    rendered.should have_selector(:div, :id => "no-record-found")
    rendered.should_not have_selector(:div, :id => "paginations")
  end

  describe 'with projects' do
    before(:each) do
      @projects = []
      @projects << Factory(:xmanager)
      @projects << Factory(:xamaze)
      @projects.should_receive(:total_pages).twice.and_return(1)
    end

    describe 'as product owners' do
      before(:each) do
        current_user(:product_owner)
        render
      end

      it "should list the projects" do
        rendered.should have_selector("div>h1>a", :content => @projects[0].name)
        rendered.should have_selector("div>p", :content => @projects[0].description)
        rendered.should have_selector("div>h1>a", :content => @projects[1].name)
        rendered.should have_selector("div>p", :content => @projects[1].description)
      end

      it "should have links for managing the project" do
        rendered.should have_selector(:div, :id => "project-mgt-#{@projects[0].id}") do |div|
          div.should have_selector(:a, :href => edit_project_path(@projects[0]))
          div.should have_selector(:a, :href => project_path(@projects[0]), 'data-method' => 'delete')
        end
      end

      it "should have a create button" do
        rendered.should have_selector(:a, :href => new_project_path, :content => "New")
      end
    end

    describe 'as scrum masters' do
      before(:each) do
        current_user(:scrum_master)
        render
      end

      it 'should not have links for managing the project' do
        rendered.should_not have_selector(:div, :id => "project-mgt-#{@projects[0].id}")
      end

      it "should not have a create button" do
        rendered.should_not have_selector(:a, :href => new_project_path)
      end
    end

    describe 'as developers' do
      before(:each) do
        current_user(:developer)
        render
      end

      it 'should not have links for managing the project' do
        rendered.should_not have_selector(:div, :id => "project-mgt-#{@projects[0].id}")
      end

      it "should not have a create button" do
        rendered.should_not have_selector(:a, :href => new_project_path)
      end
    end
  end
end
