# encoding: utf-8
Factory.define :project_role, :class => ProjectRole do |f|
  f.sequence(:role_name) { |n| "role#{n + 100}" }
  f.association :project
end