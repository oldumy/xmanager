class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 40
      t.column :crypted_password,          :string
      t.column :password_salt,             :string
      t.column :persistence_token,         :string
      t.belongs_to :role
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
