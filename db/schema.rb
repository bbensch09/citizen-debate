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

ActiveRecord::Schema.define(version: 20160402001708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "civility_votes", force: :cascade do |t|
    t.integer  "voter_id"
    t.integer  "debate_id"
    t.integer  "debater_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debate_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vote_for"
    t.integer  "debate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debaters", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "debates", force: :cascade do |t|
    t.integer  "affirmative_id"
    t.integer  "negative_id"
    t.integer  "judge_left_id"
    t.integer  "judge_right_id"
    t.string   "status"
    t.date     "start_date"
    t.datetime "start_time"
    t.integer  "verdict_id"
    t.integer  "topic_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "judges", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "slant_profile"
    t.float    "slant_historical"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "message_content"
    t.integer  "round_id"
    t.boolean  "unread"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.integer  "age"
    t.string   "about_me"
    t.string   "display_name"
    t.string   "political_affiliation"
    t.integer  "points",                default: 0
    t.integer  "rank"
    t.string   "snippets"
    t.integer  "nps"
    t.string   "pmf"
    t.string   "linkedin_profile"
    t.string   "verification_status",   default: "not yet verified"
    t.string   "cohort",                default: "wait list"
    t.integer  "extra_info",            default: 0
    t.integer  "user_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "debate_id"
    t.integer  "round_number"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "snippets", force: :cascade do |t|
    t.string   "email"
    t.string   "body"
    t.integer  "rating"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "snippets", ["user_id"], name: "index_snippets_on_user_id", using: :btree

  create_table "topic_votes", force: :cascade do |t|
    t.integer  "value"
    t.integer  "voter_id",   null: false
    t.integer  "topic_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verdicts", force: :cascade do |t|
    t.string   "status"
    t.string   "opinion_left"
    t.string   "opinion_right"
    t.integer  "winner"
    t.string   "confirmed_judges"
    t.string   "confirmed_public"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
