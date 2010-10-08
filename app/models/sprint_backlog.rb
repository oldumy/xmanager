class SprintBacklog < ActiveRecord::Base
  belongs_to :product_backlog
  belongs_to :sprint

  validates :sprint, :presence => true
  validates :product_backlog, :presence => true
end
