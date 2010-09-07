# encoding: utf-8
Factory.define :admin, :class => User do |a|
  a.login 'admin'
  a.name 'Administrator'
  a.password '123456'
  a.password_confirmation '123456'
  a.association :role, :factory => :administrators
end

Factory.define :product_manager, :class => User do |pm|
  pm.login 'product_manager'
  pm.name 'Product Manager'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.association :role, :factory => :product_managers
end

Factory.define :project_manager, :class => User do |pm|
  pm.login 'project_manager'
  pm.name 'Project Manager'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.association :role, :factory => :project_managers
end

Factory.define :developer, :class => User do |d|
  d.login 'developer'
  d.name 'Developer'
  d.password '123456'
  d.password_confirmation '123456'
  d.association :role, :factory => :developers
end

Factory.define :user, :class => User  do |u|
  u.sequence(:login) { |n| "arthur#{n+1}" }
  u.name "arthurzhou"
  u.password "111111"
  u.password_confirmation "111111"
  u.role {|role| role.association(:role) }
end
