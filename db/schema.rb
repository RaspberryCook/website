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

ActiveRecord::Schema.define(version: 20160723122747) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
    t.integer  "note"
  end

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "description"
    t.text     "ingredients"
    t.text     "steps"
    t.string   "category"
    t.string   "season"
    t.integer  "t_baking"
    t.integer  "t_cooling"
    t.integer  "t_cooking"
    t.integer  "t_rest"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "photo"
    t.string   "image"
    t.integer  "rank"
    t.integer  "root_recipe_id",     default: 0
  end

  create_table "users", force: true do |t|
    t.string   "nom"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.string   "photo"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
