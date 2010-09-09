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

ActiveRecord::Schema.define(:version => 20100908070655) do

  create_table "backlogs", :force => true do |t|
    t.string   "what"
    t.string   "why"
    t.decimal  "story_points",        :precision => 10, :scale => 1
    t.integer  "level"
    t.text     "inspection"
    t.decimal  "actual_story_points", :precision => 10, :scale => 1
    t.integer  "status",                                             :default => 0
    t.string   "description"
    t.integer  "project_id"
    t.integer  "sprint_id"
    t.integer  "project_role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_roles", :force => true do |t|
    t.string   "role_name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "roles", :force => true do |t|
    t.string   "role_name",   :limit => 40
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sprints", :force => true do |t|
    t.string   "name"
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_histories", :force => true do |t|
    t.integer  "task_id"
    t.date     "date"
    t.float    "surplus_workload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.float    "workload"
    t.float    "progress"
    t.integer  "backlog_id"
    t.float    "surplus_workload"
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

end
