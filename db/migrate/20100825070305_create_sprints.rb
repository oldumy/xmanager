class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name, :null => false, :limit => 100
      t.date :started_on, :null => false
      t.date :closed_on, :null => false
      t.text :description
      t.belongs_to :release, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
