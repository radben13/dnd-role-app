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

ActiveRecord::Schema.define(version: 20151020083757) do

  create_table "attr_sets", force: :cascade do |t|
    t.integer  "constitution"
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "wisdom"
    t.integer  "charisma"
    t.integer  "role_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "attr_sets", ["role_id"], name: "index_attr_sets_on_role_id"

  create_table "item_properties", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text   "description"
  end

  add_index "item_properties", ["slug"], name: "index_item_properties_on_slug", unique: true

  create_table "item_properties_items", id: false, force: :cascade do |t|
    t.integer "item_id",          null: false
    t.integer "item_property_id", null: false
  end

  add_index "item_properties_items", ["item_id", "item_property_id"], name: "index_item_properties_items_on_item_id_and_item_property_id"
  add_index "item_properties_items", ["item_property_id", "item_id"], name: "index_item_properties_items_on_item_property_id_and_item_id"

  create_table "items", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "slug",             null: false
    t.string   "type"
    t.string   "img_url"
    t.text     "modifier"
    t.integer  "price_in_copper"
    t.integer  "weight"
    t.boolean  "can_be_weapon",    null: false
    t.boolean  "can_be_armor",     null: false
    t.integer  "armor"
    t.integer  "dmg_dice_value_s"
    t.integer  "dmg_dice_count_s"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "description"
    t.integer  "dmg_dice_count_m"
    t.integer  "dmg_dice_value_m"
    t.string   "dmg_type"
    t.string   "critical"
    t.integer  "range"
  end

  add_index "items", ["can_be_armor"], name: "index_items_on_can_be_armor"
  add_index "items", ["can_be_weapon"], name: "index_items_on_can_be_weapon"
  add_index "items", ["slug"], name: "index_items_on_slug"

  create_table "players", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "profile_img_url"
    t.integer  "pin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "players", ["name"], name: "index_players_on_name"

  create_table "proficiencies", force: :cascade do |t|
    t.string "name",        null: false
    t.string "group"
    t.string "slug"
    t.text   "description"
  end

  add_index "proficiencies", ["slug"], name: "index_proficiencies_on_slug", unique: true

  create_table "proficiencies_roles", id: false, force: :cascade do |t|
    t.integer "proficiency_id", null: false
    t.integer "role_id",        null: false
  end

  add_index "proficiencies_roles", ["proficiency_id", "role_id"], name: "index_proficiencies_roles_on_proficiency_id_and_role_id"
  add_index "proficiencies_roles", ["role_id", "proficiency_id"], name: "index_proficiencies_roles_on_role_id_and_proficiency_id"

  create_table "role_items", force: :cascade do |t|
    t.integer "role_id"
    t.integer "item_type_id"
  end

  add_index "role_items", ["role_id"], name: "index_role_items_on_role_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "race"
    t.string   "role_type"
    t.text     "description"
    t.integer  "level"
    t.integer  "experience"
    t.integer  "money_in_copper"
    t.integer  "player_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "gender"
    t.string   "img_url"
  end

  add_index "roles", ["player_id"], name: "index_roles_on_player_id"

end
