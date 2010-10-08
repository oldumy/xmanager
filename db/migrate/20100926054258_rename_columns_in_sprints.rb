class RenameColumnsInSprints < ActiveRecord::Migration
  def self.up
    rename_column(:sprints, :started_on, :estimated_started_on)
    rename_column(:sprints, :closed_on, :estimated_closed_on)
  end

  def self.down
    rename_column(:sprints, :estimated_started_on, :started_on)
    rename_column(:sprints, :estimated_closed_on, :closed_on)
  end
end
