Factory.define :xamaze, :class => Project do |p|
  p.name "XAmaze"
  p.description "XAmaze is restaurant management system"
  p.creater do |creater|
    User.find_by_login("oldumy") || Factory(:oldumy)
  end
end

Factory.define :xmanager, :class => Project do |p|
  p.name "XManager"
  p.description "XManager is a scrum management system"
  p.creater do |creater|
    User.find_by_login("oldumy") || Factory(:oldumy)
  end
end

Factory.define :sca, :class => Project do |p|
  p.name "SCA"
  p.description "SCA is system used to analyze the source codes"
  p.association :creater, :factory => :tower
end

Factory.define :project, :class => Project do |p|
  p.name "project"
  p.description "Project without associations"
end
