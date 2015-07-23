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

ActiveRecord::Schema.define(version: 20150722213109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daytypes", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "picturesofwinners", force: :cascade do |t|
    t.integer  "quest_item_id",         null: false
    t.date     "goaldate"
    t.time     "besttime"
    t.string   "description"
    t.string   "photourl_file_name"
    t.string   "photourl_content_type"
    t.integer  "photourl_file_size"
    t.datetime "photourl_updated_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "picturesofwinners", ["quest_item_id"], name: "index_picturesofwinners_on_quest_item_id", using: :btree

  create_table "price_presets", force: :cascade do |t|
    t.integer "quest_item_id",             null: false
    t.integer "daytype_id",                null: false
    t.time    "t0",                        null: false
    t.time    "t1",                        null: false
    t.integer "price",         default: 0
  end

  add_index "price_presets", ["daytype_id"], name: "index_price_presets_on_daytype_id", using: :btree
  add_index "price_presets", ["quest_item_id"], name: "index_price_presets_on_quest_item_id", using: :btree
  add_index "price_presets", ["t0"], name: "index_price_presets_on_t0", using: :btree
  add_index "price_presets", ["t1"], name: "index_price_presets_on_t1", using: :btree

  create_table "quest_items", force: :cascade do |t|
    t.integer "quest_status_id", default: 2
    t.string  "name",            default: "Название квеста"
    t.integer "session_length",  default: 75
  end

  add_index "quest_items", ["quest_status_id"], name: "index_quest_items_on_quest_status_id", using: :btree

  create_table "quest_statuses", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.integer  "quest_item_id", null: false
    t.integer  "user_id",       null: false
    t.string   "content"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "responses", ["quest_item_id"], name: "index_responses_on_quest_item_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "ticket_statuses", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "dt",                             null: false
    t.integer  "quest_item_id",                  null: false
    t.integer  "daytype_id",                     null: false
    t.integer  "ticket_status_id",   default: 1
    t.integer  "user_id"
    t.integer  "price",              default: 0
    t.datetime "reserve_start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["daytype_id"], name: "index_tickets_on_daytype_id", using: :btree
  add_index "tickets", ["quest_item_id"], name: "index_tickets_on_quest_item_id", using: :btree
  add_index "tickets", ["ticket_status_id"], name: "index_tickets_on_ticket_status_id", using: :btree
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_foreign_key "picturesofwinners", "quest_items", name: "picturesofwinners_quest_item_fk", on_delete: :cascade
  add_foreign_key "price_presets", "daytypes", name: "price_preset_day_type_fk", on_delete: :cascade
  add_foreign_key "price_presets", "quest_items", name: "price_preset_quest_item_fk", on_delete: :cascade
  add_foreign_key "quest_items", "quest_statuses", name: "quest_item_quest_status_fk", on_delete: :cascade
  add_foreign_key "tickets", "daytypes", name: "ticket_daytype_fk", on_delete: :cascade
  add_foreign_key "tickets", "quest_items", name: "ticket_quest_item_fk", on_delete: :cascade
  add_foreign_key "tickets", "ticket_statuses", name: "ticket_status_fk", on_delete: :cascade
end
