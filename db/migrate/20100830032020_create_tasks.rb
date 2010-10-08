class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name, :null => false, :limit => 100
      t.integer :estimated_hours
      t.date :closed_on
      t.text :description
      t.belongs_to :team_member
      t.belongs_to :product_backlog, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
