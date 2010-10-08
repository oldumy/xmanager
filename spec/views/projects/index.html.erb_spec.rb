require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'projects/index.html.erb' do
  it "should have a no record found div" do
    current_user(:yanny)
    @projects = []
    render

    rendered.should_not have_selector(:div, :id => "projects")
    rendered.should have_selector(:p, :id => "no-record-found")
    rendered.should_not have_selector(:div, :id => "paginations")
  end

  describe 'with projects' do
    describe 'as product owners' do
      before(:each) do
        @oldumy = current_user(:oldumy)
        @projects = [Factory(:xmanager), Factory(:xamaze)]
        @projects.should_receive(:total_pages).and_return(1)
      end

      it 'should have a container <div id="projects"/>' do
        render
        rendered.should have_selector("div#projects")
      end

      it 'should link to the on air sprint page' do
        render
        rendered.should have_selector("#project-#{@projects[0].id}>h1>a", :href => on_air_project_sprints_path(@projects[0]), :content => @projects[0].name)
      end

      it "should list the projects" do
        render
        rendered.should have_selector("div>h1>a", :content => @projects[0].name)
        rendered.should have_selector("div>p", :content => @projects[0].description)
        rendered.should have_selector("div>h1>a", :content => @projects[1].name)
        rendered.should have_selector("div>p", :content => @projects[1].description)
      end

      it "should have links for managing the project" do
        render
        rendered.should have_selector("#project-#{@projects[0].id}>h1>span.actions") do |div|
          div.should have_selector(:a, :href => edit_project_path(@projects[0]))
          div.should have_selector(:a, :href => project_path(@projects[0]), 'data-method' => 'delete')
        end
      end

      it "should have a new project button" do
        render
        rendered.should have_selector(:a, :href => new_project_path, :content => "New")
      end
    end

    describe 'as scrum masters' do
      before(:each) do
        @venus = current_user(:venus)
        @projects = []
        @projects << Factory(:xmanager)
        @projects << Factory(:xamaze)
        @projects.should_receive(:total_pages).and_return(1)
        render
      end

      it 'should not have links for managing the project' do
        rendered.should_not have_selector(:div, :id => "project-mgt-#{@projects[0].id}")
      end

      it "should not have a new project button" do
        rendered.should_not have_selector(:a, :href => new_project_path)
      end
    end

    describe 'as developers' do
      before(:each) do
        @yanny = current_user(:yanny)
        @projects = []
        @projects << Factory(:xmanager)
        @projects[0].team_members.create!(:user => @yanny)
        @projects.should_receive(:total_pages).and_return(1)
        render
      end

      it 'should only see the projects joined in' do
        rendered.should have_selector("div>h1>a", :content => @projects[0].name)
      end

      it 'should not have links for managing the project' do
        rendered.should_not have_selector(:div, :id => "project-mgt-#{@projects[0].id}")
      end

      it "should not have a new project button" do
        rendered.should_not have_selector(:a, :href => new_project_path)
      end
    end
  end
end
