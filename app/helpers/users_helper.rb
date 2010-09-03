# encoding: utf-8
module UsersHelper
  def role_description(user)
    if user.role.nil?
      "未分配角色"
    else
      user.role.description
    end
  end
end