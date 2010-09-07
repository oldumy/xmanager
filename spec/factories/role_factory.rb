# encoding: utf-8

Factory.define :administrators, :class => Role do |a|
  a.role_name 'administrators'
  a.description 'Administrators of XManager' 
end

Factory.define :project_managers, :class => Role do |pm|
  pm.role_name 'project_managers'
  pm.description 'Project Managers of XManager' 
end

Factory.define :role, :class => Role  do |r|
  r.sequence(:role_name) { |n| "role#{n+1}" }
  r.description "项目经理"
end
