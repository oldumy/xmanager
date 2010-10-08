class CreateWorklogs < ActiveRecord::Migration
  def self.up
    create_table :worklogs do |t|
      t.integer :remaining_hours
      t.text :description
      t.belongs_to :task

      t.timestamps
    end
  end

  def self.down
    drop_table :worklogs
  end
end
