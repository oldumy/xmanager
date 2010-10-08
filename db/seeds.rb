# encoding: utf-8

administrators = Role.create(:role_name => "administrators",:description => I18n.t("roles.administrators"))
product_owners = Role.create(:role_name => "product_owners",:description => I18n.t("roles.product_owners"))
scrum_masters = Role.create(:role_name => "scrum_masters",:description => I18n.t("roles.scrum_masters"))
developers = Role.create(:role_name => "developers",:description => I18n.t("roles.developers"))

administrator = User.create(:login => "admin",
  :name =>  "Administrator",
  :password => '123456',
  :password_confirmation => '123456',
  :role => administrators
)

load File.dirname(__FILE__) + '/dummies.rb' if Rails.env.eql?('development')
