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

ActiveRecord::Schema.define(version: 20140717231455) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_stage_values", force: true do |t|
    t.text     "name"
    t.integer  "amount"
    t.integer  "task_board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_hours",   default: 0.0
  end

  add_index "daily_stage_values", ["task_board_id"], name: "index_daily_stage_values_on_task_board_id", using: :btree

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
