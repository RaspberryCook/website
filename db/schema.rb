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

ActiveRecord::Schema.define(version: 20170628103711) do

  create_table "allergens", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "icon",       limit: 255
  end

  create_table "allergens_recipes", id: false, force: :cascade do |t|
    t.integer  "recipe_id",   limit: 4
    t.integer  "allergen_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id",  limit: 4
    t.integer  "rate",       limit: 4,   default: 5
  end

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id",   limit: 4
    t.string   "readable_type", limit: 255, null: false
    t.integer  "reader_id",     limit: 4
    t.string   "reader_type",   limit: 255, null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true, using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "user_id",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",    limit: 65535
    t.text     "ingredients",    limit: 65535
    t.text     "steps",          limit: 65535
    t.string   "season",         limit: 255
    t.time     "t_baking"
    t.time     "t_cooling"
    t.time     "t_cooking"
    t.time     "t_rest"
    t.string   "photo",          limit: 255
    t.string   "image",          limit: 255
    t.integer  "root_recipe_id", limit: 4,     default: 0
    t.string   "variant_name",   limit: 255
    t.string   "rtype",          limit: 255
    t.string   "slug",           limit: 255
    t.integer  "baking",         limit: 4,     default: 0
    t.integer  "cooling",        limit: 4,     default: 0
    t.integer  "rest",           limit: 4,     default: 0
    t.integer  "cooking",        limit: 4,     default: 0
  end

  add_index "recipes", ["slug"], name: "index_recipes_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",            limit: 255
    t.string   "email",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo",               limit: 255
    t.string   "lastname",            limit: 255
    t.string   "firstname",           limit: 255
    t.string   "persistence_token",   limit: 255
    t.string   "crypted_password",    limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "single_access_token", limit: 255
    t.string   "perishable_token",    limit: 255
    t.integer  "login_count",         limit: 4,   default: 0, null: false
    t.integer  "failed_login_count",  limit: 4,   default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",    limit: 255
    t.string   "last_login_ip",       limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "views", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
    t.integer  "value",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
