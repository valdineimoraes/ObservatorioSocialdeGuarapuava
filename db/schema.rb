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

ActiveRecord::Schema.define(version: 2018_07_04_002551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "councilmen", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "office"
    t.string "political_party"
    t.bigint "political_mandate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["political_mandate_id"], name: "index_councilmen_on_political_mandate_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.date "date"
    t.time "start_session"
    t.time "end_session"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "political_mandates", force: :cascade do |t|
    t.date "first_period"
    t.date "final_period"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_kinds", force: :cascade do |t|
    t.string "kind"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "meeting_id"
    t.string "name"
    t.text "description"
    t.bigint "project_kind_id"
    t.time "start_project"
    t.time "end_project"
    t.integer "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "councilman_id"
    t.index ["councilman_id"], name: "index_projects_on_councilman_id"
    t.index ["meeting_id"], name: "index_projects_on_meeting_id"
    t.index ["project_kind_id"], name: "index_projects_on_project_kind_id"
  end

  create_table "session_councilmen", force: :cascade do |t|
    t.bigint "meeting_id"
    t.bigint "councilman_id"
    t.time "arrival", default: "2000-01-01 00:00:00"
    t.time "leaving"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "present", default: false
    t.index ["councilman_id"], name: "index_session_councilmen_on_councilman_id"
    t.index ["meeting_id"], name: "index_session_councilmen_on_meeting_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "councilman_id"
    t.integer "vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["councilman_id"], name: "index_votes_on_councilman_id"
    t.index ["project_id"], name: "index_votes_on_project_id"
  end

  add_foreign_key "councilmen", "political_mandates"
  add_foreign_key "projects", "councilmen"
  add_foreign_key "projects", "meetings"
  add_foreign_key "projects", "project_kinds"
  add_foreign_key "session_councilmen", "councilmen"
  add_foreign_key "session_councilmen", "meetings"
  add_foreign_key "votes", "councilmen"
  add_foreign_key "votes", "projects"
end
