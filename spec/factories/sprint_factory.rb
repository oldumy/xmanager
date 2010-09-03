# encoding: utf-8

Factory.define :sprint, :class => Sprint do |s|
  s.sequence(:name) { |n| "迭代#{n+1}" }
  s.start_time "2010-08-26"
  s.end_time "2010-08-27"
  s.project {|project| project.association(:project)}
end
