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

ActiveRecord::Schema.define(version: 2021_03_14_045824) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "race_id", null: false
    t.integer "planet_id", null: false
    t.string "birth_year"
    t.string "eye_color"
    t.string "gender"
    t.string "hair_color"
    t.string "height"
    t.string "skin_color"
    t.string "url"
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
    t.text "opening_crawl"
    t.string "producer"
    t.date "release_date"
    t.string "url"
    t.integer "episode_id"
    t.string "director"
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
    t.string "climate"
    t.string "diameter"
    t.integer "gravity"
    t.integer "orbital_period"
    t.integer "population"
    t.integer "rotation_period"
    t.integer "surface_water"
    t.string "terrain"
    t.string "url"
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "planet_id", null: false
    t.integer "average_lifespan"
    t.string "classification"
    t.string "designation"
    t.string "language"
    t.string "url"
    t.index ["planet_id"], name: "index_races_on_planet_id"
  end

  add_foreign_key "characters", "planets"
  add_foreign_key "characters", "races"
  add_foreign_key "races", "planets"
end
