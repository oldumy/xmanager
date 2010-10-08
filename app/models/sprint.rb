class Sprint < ActiveRecord::Base
  belongs_to :release
  has_many :sprint_backlogs, :dependent => :destroy
  has_many :product_backlogs, :through => :sprint_backlogs
  scope :unclosed, where("closed_on IS NULL")

  validates :name, :presence => true, :length => { :within => 1..100 }
  validates :estimated_started_on, :presence => true
  validates :estimated_closed_on, :presence => true
  validates :release, :presence => true

  validate :must_close_after_starting

  def start
    update_attribute(:started_on, Time.now.to_date) if sprint_backlogs.exists?
  end

  def started?
    not started_on.nil?
  end

  def closable?
    started? && sprint_backlogs.exists? && (not product_backlogs.unclosed.exists?)
  end

  def close
    closable? ? update_attribute(:closed_on, Time.now.to_date) : false
  end

  def closed?
    not closed_on.nil?
  end

  def on_air?
    started? && (not closed?)
  end

  def reopen
    update_attribute(:closed_on, nil) if closed?
  end

  def story_points
    product_backlogs.sum(:estimated_story_points)
  end

  def estimated_hours
    product_backlogs.inject(0) { |sum, backlog| sum += backlog.tasks.sum(:estimated_hours) }
  end

  def remaining_hours
    product_backlogs.inject(0) do |sum, backlog|
      sum += backlog.tasks.inject(0) { |s, task| s += task.remaining_hours }
    end
  end

  def self.on_air
    where("started_on IS NOT NULL").where("closed_on IS NULL").first
  end
  
  private
  def must_close_after_starting
    errors.add(:estimated_closed_on, I18n.t("activerecord.errors.invalid_date_range")) if estimated_closed_on.nil? || estimated_closed_on < estimated_started_on
  end
end
