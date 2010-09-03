# encoding: utf-8
Factory.define :project, :class => Project do |f|
  f.sequence(:name) {|n| "project#{n+1}"}
end
