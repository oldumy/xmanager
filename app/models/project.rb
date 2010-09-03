class Project < ActiveRecord::Base
  has_many :backlogs, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
  has_many :sprints, :dependent => :destroy
  has_many :project_roles, :dependent => :destroy
  has_many :tasks
end
