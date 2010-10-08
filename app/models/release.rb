class Release < ActiveRecord::Base
  belongs_to :project
  has_many :sprints, :dependent => :destroy

  validates :name, :presence => true, :length => { :within => 1..100 }
  validates :project, :presence => true

  scope :released, where("released_on IS NOT NULL")
  scope :unreleased, where("released_on IS NULL")

  def story_points
    sprints.inject(0) { |sum, sprint| sum += sprint.story_points }
  end

  def release
    update_attribute(:released_on, Time.now.to_date) if releasable?
  end

  def released?
    not released_on.nil?
  end

  def turnback
    update_attribute(:released_on, nil) if released?
  end

  def releasable?
    sprints.count > 0 && (not sprints.unclosed.exists?)
  end
end
