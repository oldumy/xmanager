class ProductBacklog < ActiveRecord::Base
  default_scope order("priority ASC")

  belongs_to :project
  has_one :sprint_backlog
  has_many :tasks, :dependent => :destroy

  scope :unclosed, where("closed_on IS NULL")
  scope :unscheduled, includes(:sprint_backlog).where("sprint_backlogs.id is NULL")

  def closable?
    tasks.exists? && (not tasks.unclosed.exists?)
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
