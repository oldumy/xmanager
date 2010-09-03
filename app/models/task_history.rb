class TaskHistory < ActiveRecord::Base
  belongs_to :task

  validates :date, :presence => true
  validates :task, :presence => true
  validates :surplus_workload, :presence => true, :numericality => true
end
