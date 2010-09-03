class ProjectRole < ActiveRecord::Base
  belongs_to :project
  has_many :backlogs
  validates :project, :presence => true
  validates :role_name, :presence => true, :uniqueness => true
end
