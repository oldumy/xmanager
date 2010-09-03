class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.date :start_time
      t.date :end_time
      t.references :project
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
