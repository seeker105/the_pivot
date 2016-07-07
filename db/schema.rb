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

ActiveRecord::Schema.define(version: 20160707204132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

  create_table "business_admins", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "business_admins", ["business_id"], name: "index_business_admins_on_business_id", using: :btree
  add_index "business_admins", ["user_id"], name: "index_business_admins_on_user_id", using: :btree

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",      default: false
    t.string   "slug"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "description"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "categories_items", id: false, force: :cascade do |t|
    t.integer "item_id",     null: false
    t.integer "category_id", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.decimal  "price"
    t.string   "image"
    t.integer  "status",      default: 0
    t.datetime "end_time"
    t.integer  "business_id"
  end

  add_index "items", ["business_id"], name: "index_items_on_business_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "email"
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "platform_admin",  default: false
  end

  add_foreign_key "bids", "items"
  add_foreign_key "bids", "users"
  add_foreign_key "business_admins", "businesses"
  add_foreign_key "business_admins", "users"
  add_foreign_key "items", "businesses"
end
