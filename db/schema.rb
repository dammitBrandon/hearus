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
    t.string   "rep_email_form"
    t.string   "rep_party"
    t.string   "rep_phone"
    t.string   "rep_twitter"
    t.string   "rep_facebook"
    t.string   "rep_youtube"
    t.string   "rep_wiki"
    t.string   "bioguide_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "politicians", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "abbreviation"
    t.string   "full_name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "district_id"
    t.integer  "district_number"
    t.string   "state_abbreviation"
    t.string   "state_full_name"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "rep_name"
    t.string   "rep_email_form"
    t.string   "rep_party"
    t.string   "rep_phone"
    t.string   "rep_twitter"
    t.string   "rep_facebook"
    t.string   "rep_youtube"
    t.string   "rep_wiki"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "votes", :force => true do |t|
    t.string   "choice"
    t.integer  "user_id"
    t.string   "bill_id"
    t.integer  "tweeted"
    t.datetime "tweeted_at"
  end

end
