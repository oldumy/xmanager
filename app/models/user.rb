class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :role

  validates :login, :presence => true, :uniqueness => true
  validates :role, :presence => true
  validates_length_of :name, :maximum => 40
  validates_length_of :login, :within => 3..40
  def role_symbols
    @role_symbols ||= ([self.role.role_name.to_sym] ||[])
  end
end
