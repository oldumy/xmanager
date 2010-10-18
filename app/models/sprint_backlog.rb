class SprintBacklog < ActiveRecord::Base
  default_scope joins(:product_backlog).order("product_backlogs.priority ASC")

  belongs_to :product_backlog
  belongs_to :sprint

  validates :sprint, :presence => true
  validates :product_backlog, :presence => true
end
