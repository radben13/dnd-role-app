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

ActiveRecord::Schema.define(version: 20150918173135) do

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "price_in_copper"
    t.integer  "weight"
    t.integer  "dmg_dice_id"
    t.integer  "dmg_dice_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "dmg_dice"
    t.string   "stat_modifiers"
  end

  add_index "items", ["dmg_dice_id"], name: "index_items_on_dmg_dice_id"

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "profile_img_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "race"
    t.string   "roleType"
    t.text     "description"
    t.integer  "level"
    t.integer  "experience"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "player_id"
  end

  add_index "roles", ["player_id"], name: "index_roles_on_player_id"

end
