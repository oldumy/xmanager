class Project < ActiveRecord::Base
  belongs_to :creater, :class_name => "User"

  has_many :product_backlogs, :dependent => :destroy
  has_many :releases, :dependent => :destroy
  has_many :team_members, :dependent => :destroy
  has_many :sprints, :through => :releases

  validates :name, :presence => true, :uniqueness => true, :length => { :within => 1..20 }
  validates :creater, :presence => true

  def created_by?(user)
    creater == user  
  end

  def started?
    not sprints.on_air.nil?
  end

  def self.created_by_or_has_member(user)
    includes(:team_members).
      where("projects.creater_id=? or team_members.user_id=?", user, user).
      order('name ASC')
  end

end
