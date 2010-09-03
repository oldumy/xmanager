# To change this template, choose Tools | Templates
# and open the template in the editor.

class UserSession < Authlogic::Session::Base
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key)]
  end
  # the configuration block is optional
  # specify configuration here, such as:
  # logout_on_timeout true
  # ...many more options in the documentation
end
