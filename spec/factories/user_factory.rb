# encoding: utf-8
Factory.define :role, :class => Role  do |r|
  r.sequence(:role_name) { |n| "role#{n+1}" }
  r.description "项目经理"
end
Factory.define :user, :class => User  do |u|
  u.sequence(:login) { |n| "arthur#{n+1}" }
  u.name "arthurzhou"
  u.password "111111"
  u.password_confirmation "111111"
  u.role {|role| role.association(:role) }
end
