class CreateProductBacklogs < ActiveRecord::Migration
  def self.up
    create_table :product_backlogs do |t|
      t.string :name, :null => false
      t.integer :priority
      t.integer :estimated_story_points
      t.date :closed_on
      t.text :description
      t.text :acceptance_criteria
      t.belongs_to :project, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :product_backlogs
  end
end
