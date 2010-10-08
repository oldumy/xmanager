Factory.define :task, :class => Task do |t|
  t.name "Define the properties of the product backlog"
  t.description "Description of the task"
  t.estimated_hours 4
  t.product_backlog do |backlog|
    backlog = ProductBacklog.find_by_name("Create product backlogs") || Factory(:create_product_backlogs)
  end
  t.team_member do |member|
    user = User.find_by_login("oldumy") || Factory(:oldumy)
    member = TeamMember.find_by_user_id(user.id) || Factory(:tm_oldumy)
  end
end

Factory.define :fake_task, :class => Task do |t|
  t.name Faker::Lorem.sentence
  t.description Faker::Lorem.sentences
  t.estimated_hours rand(8)
end
