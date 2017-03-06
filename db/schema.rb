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

ActiveRecord::Schema.define(version: 20170306071317) do

  create_table "checkouts", force: :cascade do |t|
    t.integer  "target_id",   limit: 4
    t.text     "description", limit: 65535
    t.datetime "created_at",                                         null: false
    t.decimal  "latitude",                  precision: 10, scale: 6
    t.decimal  "longitude",                 precision: 10, scale: 6
  end

  create_table "logs", force: :cascade do |t|
    t.datetime "created_at",                                    null: false
    t.integer  "target_id",  limit: 4
    t.decimal  "latitude",             precision: 10, scale: 6
    t.decimal  "longitude",            precision: 10, scale: 6
  end

  create_table "targets", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "tracking_id",        limit: 255
    t.integer  "user_id",            limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.string   "image",              limit: 255
    t.integer  "phone_no",           limit: 8
  end

  create_table "users", force: :cascade do |t|
    t.string  "email",             limit: 255
    t.string  "password_digest",   limit: 255
    t.string  "organisation_name", limit: 255
    t.integer "phone_no",          limit: 8
    t.string  "auth_token",        limit: 255
  end

end
