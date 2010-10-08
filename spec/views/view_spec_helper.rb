require 'spec_helper'

def current_user(name = nil)
  @@current_user = User.find_by_login(name.to_s) || Factory(name) unless name.nil?
  @@current_user
end

