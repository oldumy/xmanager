# encoding: utf-8

Factory.define :administrators, :class => Role do |a|
  a.role_name 'administrators'
  a.description 'Administrators of XManager' 
end

Factory.define :product_owners, :class => Role do |pm|
  pm.role_name 'product_owners'
  pm.description 'Product owners' 
end

Factory.define :scrum_masters, :class => Role do |pm|
  pm.role_name 'scrum_masters'
  pm.description 'Scrum masters of a project' 
end

Factory.define :developers, :class => Role do |d|
  d.role_name 'developers'
  d.description 'Developers of a project' 
end

Factory.define :role, :class => Role  do |r|
  r.sequence(:role_name) { |n| "role#{n+1}" }
  r.description "项目经理"
end
