class CreateBacklogs < ActiveRecord::Migration
  def self.up
    create_table :backlogs do |t|
      t.string :what
      t.string :why
      t.decimal :story_points,:precision => 10 ,:scale => 1
      t.integer :level
      t.text :inspection
      t.decimal :actual_story_points,:precision => 10 ,:scale => 1
      t.integer :status, :default => 0
      t.string :description
      t.belongs_to :project
      t.belongs_to :sprint
      t.belongs_to :project_role
      t.timestamps
    end
  end

  def self.down
    drop_table :backlogs
  end
end
