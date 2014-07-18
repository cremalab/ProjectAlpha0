# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140718221244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "daily_stage_values", force: true do |t|
    t.text     "name"
    t.integer  "amount"
    t.integer  "task_board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_hours",   default: 0.0
  end

  add_index "daily_stage_values", ["task_board_id"], name: "index_daily_stage_values_on_task_board_id", using: :btree

  create_table "employees", force: true do |t|
    t.string   "name"
    t.string   "asana_id"
    t.string   "harvest_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  add_index "employees", ["employee_id"], name: "index_employees_on_employee_id", using: :btree

  create_table "task_boards", force: true do |t|
    t.string   "stripe_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
  end

  create_table "tasks", force: true do |t|
    t.text     "name"
    t.string   "stripe_id"
    t.string   "stage"
    t.string   "assigned_hour"
    t.integer  "task_board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["task_board_id"], name: "index_tasks_on_task_board_id", using: :btree

end
