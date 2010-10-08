# encoding: utf-8

administrators = Role.create(:role_name => "administrators",:description => "系统管理员")
product_owners = Role.create(:role_name => "product_owners",:description => "产品负责人")
scrum_masters = Role.create(:role_name => "scrum_masters",:description => "Scrum负责人")
developers = Role.create(:role_name => "developers",:description => "团队开发人员")

administrator = User.create(:login => "admin",
  :name =>  "Administrator",
  :password => '123456',
  :password_confirmation => '123456',
  :role => administrators
)

load File.dirname(__FILE__) + '/dummies.rb' if Rails.env.eql?('development')
