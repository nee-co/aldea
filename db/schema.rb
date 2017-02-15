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

ActiveRecord::Schema.define(version: 20161112160612) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "コメント" do |t|
    t.text     "body",       limit: 65535, null: false, comment: "コメント内容"
    t.integer  "event_id",                 null: false, comment: "イベントID"
    t.integer  "user_id",                  null: false, comment: "ユーザID"
    t.datetime "posted_at",                null: false, comment: "投稿日時"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["event_id"], name: "index_comments_on_event_id", using: :btree
  end

  create_table "entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "参加" do |t|
    t.integer  "event_id",   null: false, comment: "イベントID"
    t.integer  "user_id",    null: false, comment: "ユーザID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_entries_on_event_id_user_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_entries_on_event_id", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", comment: "イベント" do |t|
    t.string   "title",                                    null: false, comment: "タイトル"
    t.text     "body",       limit: 65535,                 null: false, comment: "内容"
    t.integer  "owner_id",                                 null: false, comment: "登録ユーザーID"
    t.date     "start_date",                               null: false, comment: "開催日"
    t.boolean  "is_public",                default: false, null: false, comment: "公開フラグ"
    t.string   "image",                                    null: false, comment: "イベント画像path"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_foreign_key "comments", "events", name: "comments_event_id_fk"
  add_foreign_key "entries", "events", name: "entries_event_id_fk"
end
