# encoding: utf-8

administrators = Role.create(:role_name => "administrators",:description => "系统管理员")
product_owners = Role.create(:role_name => "product_owners",:description => "产品经理")
sprint_masters = Role.create(:role_name => "scrum_masters",:description => "项目经理")
developers = Role.create(:role_name => "developers",:description => "团队开发人员")

 administrator = User.create(:login => "admin",
            :name =>  "administrator",
            :password => '111111',
            :password_confirmation => '111111',
            :role_id => administrators.id
)