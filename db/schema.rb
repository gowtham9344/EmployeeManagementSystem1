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

ActiveRecord::Schema.define(version: 2024_03_25_072805) do

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "address"
    t.string "mobile"
    t.boolean "is_manager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.string "password_digest"
    t.string "role"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["mobile"], name: "index_employees_on_mobile", unique: true
    t.index ["name"], name: "index_employees_on_name"
    t.index ["team_id"], name: "index_employees_on_team_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manager_id"
    t.index ["manager_id"], name: "index_teams_on_manager_id"
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  add_foreign_key "employees", "teams"
  add_foreign_key "teams", "employees", column: "manager_id"
end
