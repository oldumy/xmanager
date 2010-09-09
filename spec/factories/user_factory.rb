# encoding: utf-8
Factory.define :admin, :class => User do |a|
  a.login 'admin'
  a.name 'Administrator'
  a.password '123456'
  a.password_confirmation '123456'
  a.association :role, :factory => :administrators
end

Factory.define :product_owner, :class => User do |pm|
  pm.login 'product_owner'
  pm.name 'Product Owner'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.association :role, :factory => :product_owners
end

Factory.define :scrum_master, :class => User do |pm|
  pm.login 'scrum_master'
  pm.name 'Scrum Master'
  pm.password '123456'
  pm.password_confirmation '123456'
  pm.association :role, :factory => :scrum_masters
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
