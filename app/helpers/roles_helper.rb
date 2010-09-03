# encoding: utf-8
module RolesHelper
  def get_roles_list
    Role.find(:all,:order=>:description)
  end
end
