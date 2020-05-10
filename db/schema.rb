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

ActiveRecord::Schema.define(version: 2020_05_10_040815) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "position"
    t.string "countory"
    t.string "birthplace"
    t.text "career"
    t.text "person"
    t.integer "appearance_chapter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chronologies", force: :cascade do |t|
    t.integer "year"
    t.text "japan_event"
    t.text "korea_event"
    t.text "china_event"
    t.text "other_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episodes", force: :cascade do |t|
    t.integer "chapter"
    t.string "title"
    t.text "overview"
    t.text "content"
    t.string "set"
    t.string "keyword"
    t.string "keyitem"
    t.string "division"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "glossaries", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "chapter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
