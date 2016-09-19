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

ActiveRecord::Schema.define(version: 20160917142602) do

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
    t.string   "season"
    t.time     "t_baking"
    t.time     "t_cooling"
    t.time     "t_cooking"
    t.time     "t_rest"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "photo"
    t.string   "image"
    t.integer  "rank"
    t.integer  "root_recipe_id",     default: 0
    t.string   "variant_name"
    t.string   "rtype"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "password"
    t.boolean  "admin"
    t.string   "photo"
    t.string   "lastname"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
