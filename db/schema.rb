# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100929123058) do

  create_table "product_backlogs", :force => true do |t|
    t.string   "name",                   :null => false
    t.integer  "priority"
    t.integer  "estimated_story_points"
    t.date     "closed_on"
    t.text     "description"
    t.text     "acceptance_criteria"
    t.integer  "project_id",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",        :null => false
    t.integer  "creater_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "releases", :force => true do |t|
    t.string   "name",                  :limit => 100, :null => false
    t.text     "description"
    t.date     "estimated_released_on"
    t.date     "released_on"
    t.integer  "project_id",                           :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "role_name",   :limit => 40
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprint_backlogs", :force => true do |t|
    t.integer  "product_backlog_id", :null => false
    t.integer  "sprint_id",          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprints", :force => true do |t|
    t.string   "name",                 :limit => 100, :null => false
    t.date     "estimated_started_on",                :null => false
    t.date     "estimated_closed_on",                 :null => false
    t.text     "description"
    t.integer  "release_id",                          :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "started_on"
    t.date     "closed_on"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name",               :limit => 100, :null => false
    t.integer  "estimated_hours"
    t.date     "closed_on"
    t.text     "description"
    t.integer  "team_member_id"
    t.integer  "product_backlog_id",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_members", :force => true do |t|
    t.integer  "project_id", :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",             :limit => 40
    t.string   "name",              :limit => 40
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worklogs", :force => true do |t|
    t.integer  "remaining_hours"
    t.text     "description"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
