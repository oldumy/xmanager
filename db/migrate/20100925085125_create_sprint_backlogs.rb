class CreateSprintBacklogs < ActiveRecord::Migration
  def self.up
    create_table :sprint_backlogs do |t|
      t.belongs_to :product_backlog, :null => false
      t.belongs_to :sprint, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :sprint_backlogs
  end
end
