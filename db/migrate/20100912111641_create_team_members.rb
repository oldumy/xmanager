class CreateTeamMembers < ActiveRecord::Migration
  def self.up
    create_table :team_members do |t|
      t.belongs_to :project, :null => false
      t.belongs_to :user, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :team_members
  end
end
