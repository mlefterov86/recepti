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

ActiveRecord::Schema.define(version: 2022_01_16_085256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "difficulties", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_difficulties_on_name", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.bigint "author_id", null: false
    t.bigint "difficulty_id", null: false
    t.integer "prep_time"
    t.integer "cook_time"
    t.integer "total_time"
    t.decimal "rate", precision: 2, scale: 1
    t.string "budget"
    t.integer "people_quantity"
    t.text "ingredients", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_recipes_on_author_id"
    t.index ["difficulty_id"], name: "index_recipes_on_difficulty_id"
    t.index ["ingredients"], name: "index_recipes_on_ingredients", using: :gin
    t.index ["people_quantity"], name: "index_recipes_on_people_quantity"
    t.index ["rate"], name: "index_recipes_on_rate"
    t.index ["total_time"], name: "index_recipes_on_total_time"
  end

  add_foreign_key "recipes", "authors"
  add_foreign_key "recipes", "difficulties"
end
