class Task < ActiveRecord::Base
  belongs_to :team_member
  belongs_to :product_backlog
  has_many :worklogs, :dependent => :destroy

  scope :unclosed, where("closed_on IS NULL")

  validates :name, :presence => true, :length => { :within => 1..100 }
  validates :product_backlog, :presence => true

  def remaining_hours
    worklogs.exists? ? worklogs.last.remaining_hours : estimated_hours
  end

  def closable?
    worklogs.exists? && worklogs.last.remaining_hours == 0
  end

  def close
    closable? ? update_attribute(:closed_on, Time.now.to_date) : false
  end

  def closed?
    not closed_on.nil?
  end

  def reopen
    update_attribute(:closed_on, nil)
  end
end
