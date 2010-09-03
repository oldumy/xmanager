class CreateTaskHistories < ActiveRecord::Migration
  def self.up
    create_table :task_histories do |t|
      t.integer :task_id
      t.date :date
      t.float :surplus_workload

      t.timestamps
    end
  end

  def self.down
    drop_table :task_histories
  end
end
