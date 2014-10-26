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

ActiveRecord::Schema.define(version: 20140406080552) do

  create_table "campaigns", force: true do |t|
    t.text     "description"
    t.datetime "date_start"
    t.datetime "date_end"
    t.integer  "collected"
    t.integer  "goal"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "campaigns", ["user_id"], name: "index_campaigns_on_user_id"

  create_table "costs", force: true do |t|
    t.string   "name"
    t.integer  "amount"
    t.integer  "campaign_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costs", ["campaign_id"], name: "index_costs_on_campaign_id"

  create_table "donations", force: true do |t|
    t.integer  "amount"
    t.datetime "date"
    t.integer  "campaign_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["campaign_id"], name: "index_donations_on_campaign_id"
  add_index "donations", ["user_id"], name: "index_donations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.integer  "money"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.string   "password_salt"
  end

end
