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

ActiveRecord::Schema.define(version: 20160924105218) do

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.text     "ingredients"
    t.text     "steps"
    t.string   "season"
    t.time     "t_baking"
    t.time     "t_cooling"
    t.time     "t_cooking"
    t.time     "t_rest"
    t.string   "photo"
    t.string   "image"
    t.integer  "root_recipe_id", default: 0
    t.string   "variant_name"
    t.string   "rtype"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password"
    t.string   "photo"
    t.string   "lastname"
    t.string   "firstname"
  end

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
