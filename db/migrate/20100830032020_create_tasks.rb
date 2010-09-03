class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.float :workload
      t.float :progress
      t.float :surplus_workload
      t.integer :project_id
      t.integer :sprint_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
