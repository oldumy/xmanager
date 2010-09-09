# encoding: utf-8

Factory.define :xmanager, :class => Project do |p|
  p.name "XManager"
  p.description "Description of XManager"
end

Factory.define :project, :class => Project do |f|
  f.sequence(:name) {|n| "project#{n+1}"}
end
