class AddColumnsToSprints < ActiveRecord::Migration
  def self.up
    add_column :sprints, :started_on, :date
    add_column :sprints, :closed_on, :date
  end

  def self.down
    remove_column :sprints, :closed_on
    remove_column :sprints, :started_on
  end
end
