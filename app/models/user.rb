class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :role

  validates :login, :presence => true, :uniqueness => true
  validates :role, :presence => true
  validates_length_of :name, :maximum => 40
  validates_length_of :login, :within => 3..40

  def administrators?
    role_symbols.include? :administrators
  end

  def product_owners?
    role_symbols.include? :product_owners
  end

  def scrum_masters?
    role_symbols.include? :scrum_masters
  end

  def developers?
    role_symbols.include? :developers
  end

  def role_symbols
    role.nil? ? [] : [role.role_name.to_sym]
  end

  def self.in_project(project)
    TeamMember.select("users.*").
      joins(:user).
      where("team_members.project_id=?", project)
  end

  def self.not_admin(options = {})
    except = options[:except]
    users = joins(:role).where("roles.role_name!=?", "administrators")
    unless except.nil?
      except = [except] unless except.respond_to?(:empty?)
      users = users.where("users.id not in (?)", except) unless except.empty?
    end
    users
  end
end
