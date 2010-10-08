Factory.define(:tm_oldumy, :class => TeamMember) do |m|
  m.project do |project|
    project = Project.find_by_name("XManager") || Factory(:project)
  end
  m.user do |user|
    user = User.find_by_login("oldumy") || Factory(:oldumy)
  end
end
