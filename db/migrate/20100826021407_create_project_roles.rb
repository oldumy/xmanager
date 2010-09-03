class CreateProjectRoles < ActiveRecord::Migration
  def self.up
    create_table :project_roles do |t|
      t.string :role_name
      t.string :description
      t.belongs_to :project
      t.timestamps
    end
  end

  def self.down
    drop_table :project_roles
  end
end
