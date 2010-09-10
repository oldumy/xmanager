# encoding: utf-8

Factory.define :xamaze, :class => Project do |p|
  p.name "XAmaze"
  p.description "XAmaze is restaurant management system"
end

Factory.define :xmanager, :class => Project do |p|
  p.name "XManager"
  p.description "XManager is a scrum management system"
end

Factory.define :project, :class => Project do |f|
  f.sequence(:name) {|n| "project#{n+1}"}
end
