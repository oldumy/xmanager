class Worklog < ActiveRecord::Base
  belongs_to :task

  validates :task, :presence => true
  validates :remaining_hours, :presence => true, :numericality => { :greater_than_or_equal_to => 0 }
end
