class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :name, :null => false, :limit => 100
      t.text :description
      t.date :estimated_released_on
      t.date :released_on
      t.belongs_to :project, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
