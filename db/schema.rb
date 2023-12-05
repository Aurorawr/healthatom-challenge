# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_05_004335) do
  create_table "deaths", force: :cascade do |t|
    t.integer "titan_id", null: false
    t.text "cause"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["titan_id"], name: "index_deaths_on_titan_id"
  end

  create_table "deaths_resources", id: false, force: :cascade do |t|
    t.integer "death_id", null: false
    t.integer "resource_id", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sightings", force: :cascade do |t|
    t.integer "titan_id", null: false
    t.date "first_sight"
    t.date "last_sight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["titan_id"], name: "index_sightings_on_titan_id"
  end

  create_table "titans", force: :cascade do |t|
    t.string "alias"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "deaths", "titans"
  add_foreign_key "sightings", "titans"
end
