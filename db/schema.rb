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

ActiveRecord::Schema.define(version: 20150918161949) do

  create_table "items", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "slug",            null: false
    t.string   "type"
    t.string   "img_url"
    t.text     "modifier"
    t.integer  "price_in_copper"
    t.integer  "weight"
    t.boolean  "is_weapon?",      null: false
    t.boolean  "is_armor?",       null: false
    t.integer  "armor"
    t.integer  "dmg_dice_value"
    t.integer  "dmg_dice_count"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "items", ["is_armor?"], name: "index_items_on_is_armor?"
  add_index "items", ["is_weapon?"], name: "index_items_on_is_weapon?"
  add_index "items", ["slug"], name: "index_items_on_slug"

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.string   "profile_img_url"
    t.integer  "pin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "role_items", force: :cascade do |t|
    t.integer "role_id"
    t.integer "item_type_id"
  end

  add_index "role_items", ["role_id"], name: "index_role_items_on_role_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "race"
    t.string   "roleType"
    t.text     "description"
    t.integer  "level"
    t.integer  "experience"
    t.integer  "player_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["player_id"], name: "index_roles_on_player_id"

end
