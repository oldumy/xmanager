class Project < ActiveRecord::Base
  has_many :backlogs, :dependent => :destroy
  has_many :sprints, :dependent => :destroy
  has_many :project_roles, :dependent => :destroy
  has_many :tasks

  validates :name, :presence => true, :uniqueness => true
end
