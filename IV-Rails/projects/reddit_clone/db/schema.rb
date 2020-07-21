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

ActiveRecord::Schema.define(version: 2020_07_21_193349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "author_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["post_id"], name: "index_comments_on_post_id"
  end

  create_table "post_subs", force: :cascade do |t|
    t.bigint "sub_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_subs_on_post_id"
    t.index ["sub_id", "post_id"], name: "index_post_subs_on_sub_id_and_post_id", unique: true
    t.index ["sub_id"], name: "index_post_subs_on_sub_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.string "url"
    t.text "content"
    t.bigint "sub_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id"
    t.index ["sub_id"], name: "index_posts_on_sub_id"
  end

  create_table "subs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "moderator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moderator_id"], name: "index_subs_on_moderator_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_hash", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "post_subs", "posts"
  add_foreign_key "post_subs", "subs"
  add_foreign_key "posts", "subs"
end
