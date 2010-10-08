class TeamMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :project, :presence => true
  validates :user, :presence => true

  def name
    user.name
  end
end
