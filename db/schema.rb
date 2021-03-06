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

ActiveRecord::Schema.define(version: 20140802005626) do

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.text     "raw_info"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "screenshots", force: true do |t|
    t.string   "filename"
    t.string   "url",        limit: 2000
    t.string   "status",                  default: "new"
    t.integer  "webpage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "screenshots", ["webpage_id"], name: "index_screenshots_on_webpage_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",                   default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email", "username"], name: "login", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "webpage_redirects", force: true do |t|
    t.string   "url",                 limit: 2000
    t.integer  "webpage_response_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webpage_redirects", ["webpage_response_id"], name: "index_webpage_redirects_on_webpage_response_id", using: :btree

  create_table "webpage_requests", force: true do |t|
    t.string   "url",        limit: 2000,                 null: false
    t.string   "slug"
    t.string   "status",                  default: "new"
    t.integer  "user_id",                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webpage_requests", ["slug"], name: "index_webpage_requests_on_slug", unique: true, using: :btree
  add_index "webpage_requests", ["url", "user_id"], name: "index_webpage_requests_on_url_and_user_id", length: {"url"=>255, "user_id"=>nil}, using: :btree

  create_table "webpage_responses", force: true do |t|
    t.integer  "redirect_count"
    t.integer  "code"
    t.text     "headers"
    t.integer  "webpage_request_id"
    t.integer  "webpage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "webpage_responses", ["webpage_id"], name: "index_webpage_responses_on_webpage_id", using: :btree
  add_index "webpage_responses", ["webpage_request_id"], name: "index_webpage_responses_on_webpage_request_id", using: :btree

  create_table "webpages", force: true do |t|
    t.string   "url",           limit: 2000,       default: "", null: false
    t.string   "primary_ip"
    t.text     "body",          limit: 2147483647
    t.string   "content_type"
    t.string   "meta_encoding"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
