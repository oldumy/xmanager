# encoding: utf-8
class Backlog < ActiveRecord::Base
  validates_numericality_of   :story_points,  :greater_than_or_equal_to => 0, :allow_nil=>true
  validates_numericality_of   :actual_story_points,:greater_than_or_equal_to => 0, :allow_nil=>true
  validates_numericality_of   :level,  :greater_than_or_equal_to => 0, :only_integer => true,  :allow_nil=>true
  validates :status, :inclusion => { :in => 0..1 }
  validates :level, :uniqueness => true, :allow_blank => true

  validates :project, :presence => true
  
  belongs_to :sprint
  belongs_to :project_role
  belongs_to :project

  def backlog_description
    if self.description.blank?
      "作为" << (self.project_role.nil? ? "":self.project_role.role_name) << ",我可以" << self.what << ",以便"<< self.why
    else
      self.description
    end
  end
end
