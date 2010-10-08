product_owners = Role.find_by_role_name("product_owners")
scrum_masters = Role.find_by_role_name("scrum_masters")
developers = Role.find_by_role_name("developers")

tower = User.create!(:login => 'tower', :name => "Tower He", :password => '123456', :password_confirmation => '123456', :role => product_owners)
venus = User.create!(:login => 'venus', :name => "Venus", :password => '123456', :password_confirmation => '123456', :role => scrum_masters)
jessimine = User.create!(:login => 'jessimine', :name => "Jessimine He", :password => '123456', :password_confirmation => '123456', :role => developers)

xmanager = Project.create!(:name => "XManager", :description => "XManager is a scrum management system.", :creater => tower)

tm_tower = xmanager.team_members.create!(:user => tower)
tm_venus = xmanager.team_members.create!(:user => venus)
tm_jessimine = xmanager.team_members.create!(:user => jessimine)

cpb_product_backlog = xmanager.product_backlogs.create!(:name => 'Create product backlogs', :description => 'I can create product backlogs', :priority => 100, :estimated_story_points => 1)
lpb_product_backlog = xmanager.product_backlogs.create!(:name => 'List product backlogs', :description => 'I can list product backlogs', :priority => 200, :estimated_story_points => 1)

v_0_1_0 = xmanager.releases.create!(:name => '0.1.0', :description => 'The first release', :estimated_released_on => Date.parse('2010-09-30'))
v_0_2_0 = xmanager.releases.create!(:name => '0.2.0', :description => 'The second release', :estimated_released_on => Date.parse('2010-10-31'))

sprint_1 = v_0_1_0.sprints.create!(:name => 'Sprint 1', :description => 'Description of sprint 1', :estimated_started_on => Date.parse('2010-09-16'), :estimated_closed_on => Date.parse('2010-09-30'))

cpb_sprint_backlog = sprint_1.sprint_backlogs.create!(:product_backlog => cpb_product_backlog)
lpb_sprint_backlog = sprint_1.sprint_backlogs.create!(:product_backlog => lpb_product_backlog)

do_it = cpb_product_backlog.tasks.create!(:name => 'Do it', :description => "Description of 'do it'", :estimated_hours => 8, :team_member => tm_jessimine)

