class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.column :role_name, :string, :limit => 40
      t.column :description, :string, :limit =>255

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
