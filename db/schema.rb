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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130820205916) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "provider"
    t.datetime "oauth_expires"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "district_shapes", :force => true do |t|
    t.text    "shape"
    t.integer "district_id"
  end

  create_table "districts", :force => true do |t|
    t.integer  "number"
    t.integer  "state_id"
    t.string   "state_abbreviation"
    t.string   "state_full_name"
    t.string   "rep_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "districts", ["number"], :name => "index_districts_on_number"
  add_index "districts", ["state_abbreviation"], :name => "index_districts_on_state_abbreviation"

  create_table "politicians", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "gender"
    t.string   "phone"
    t.string   "website"
    t.string   "webform"
    t.string   "congress_office"
    t.string   "bioguide_id"
    t.string   "twitter_id"
    t.string   "congresspedia_url"
    t.string   "youtube_url"
    t.string   "facebook_id"
    t.string   "birthday"
    t.string   "type"
    t.integer  "district_id"
    t.integer  "state_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "abbreviation"
    t.string   "full_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "states", ["abbreviation"], :name => "index_states_on_abbreviation"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.integer  "district_id"
    t.integer  "district_number"
    t.integer  "state_id"
    t.string   "state_abbreviation"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["district_number"], :name => "index_users_on_district_number"
  add_index "users", ["state_abbreviation"], :name => "index_users_on_state_abbreviation"

  create_table "votes", :force => true do |t|
    t.string   "choice"
    t.integer  "user_id"
    t.string   "sunlight_id"
    t.integer  "tweeted"
    t.datetime "tweeted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "votes", ["choice"], :name => "index_votes_on_choice"
  add_index "votes", ["sunlight_id"], :name => "index_votes_on_sunlight_id"

end
