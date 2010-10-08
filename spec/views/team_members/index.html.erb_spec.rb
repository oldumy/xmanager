require File.dirname(__FILE__) + '/../' + 'view_spec_helper'

describe 'team_members/index.html.erb' do
  before(:each) do
    @project = Factory(:xmanager)
    current_user(:oldumy)
  end

  it 'should list the team members' do
    user = Factory(:tower)
    team_member = TeamMember.create!(:project => @project, :user => user)
    @project.team_members << team_member
    @candidates = []

    render

    rendered.should have_selector(:div, :id => "team-members") do |div|
      div.should have_selector(:a, :content => user.name, :href => project_team_member_path(@project, team_member), "data-method" => 'delete')
    end
  end

  it 'should list the candidates' do
    @candidates = [ Factory(:tower), Factory(:venus), Factory(:jessimine), Factory(:yanny) ]
    @team_members = []
    @project.should_receive(:team_members).and_return(@team_members)
    render

    rendered.should have_selector(:form, :name => 'candidates-form') do |form|
      form.should have_selector(:input, :name => 'candidates[]', :type => 'checkbox', :value => @candidates[0].id.to_s)
      form.should have_selector(:input, :name => 'candidates[]', :type => 'checkbox', :value => @candidates[1].id.to_s)
      form.should have_selector(:input, :name => 'candidates[]', :type => 'checkbox', :value => @candidates[2].id.to_s)
      form.should have_selector(:input, :name => 'candidates[]', :type => 'checkbox', :value => @candidates[3].id.to_s)
    end
  end
end
