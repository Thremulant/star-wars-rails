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

ActiveRecord::Schema.define(version: 2021_03_14_045434) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "race_id", null: false
    t.integer "planet_id", null: false
    t.index ["planet_id"], name: "index_characters_on_planet_id"
    t.index ["race_id"], name: "index_characters_on_race_id"
  end

  create_table "characters_films", id: false, force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "character_id", null: false
  end

  create_table "films", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "films_planets", id: false, force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "planet_id", null: false
  end

  create_table "films_races", id: false, force: :cascade do |t|
    t.integer "film_id", null: false
    t.integer "race_id", null: false
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "planet_id", null: false
    t.index ["planet_id"], name: "index_races_on_planet_id"
  end

  add_foreign_key "characters", "planets"
  add_foreign_key "characters", "races"
  add_foreign_key "races", "planets"
end
