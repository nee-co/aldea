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

ActiveRecord::Schema.define(version: 0) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", comment: "コメント" do |t|
    t.text     "body",       limit: 65535, null: false, comment: "コメント内容"
    t.integer  "event_id",                 null: false, comment: "イベントID"
    t.integer  "user_id",                  null: false, comment: "ユーザーID"
    t.datetime "posted_at",                null: false, comment: "投稿日時"
    t.datetime "created_at",                            comment: "レコード作成日時"
    t.datetime "updated_at",                            comment: "レコード更新日時"
    t.index ["event_id"], name: "comments_event_id_fk", using: :btree
    t.index ["user_id"], name: "comments_user_id_fk", using: :btree
  end

  create_table "entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", comment: "参加" do |t|
    t.integer  "event_id",   null: false, comment: "イベントID"
    t.integer  "user_id",    null: false, comment: "ユーザーID"
    t.datetime "created_at",              comment: "レコード作成日時"
    t.datetime "updated_at",              comment: "レコード更新日時"
    t.index ["event_id", "user_id"], name: "index_entries_on_event_id_user_id", unique: true, using: :btree
    t.index ["user_id"], name: "entries_user_id_fk", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT" do |t|
    t.string   "title",                                       null: false, comment: "タイトル"
    t.text     "body",              limit: 65535,             null: false, comment: "内容"
    t.integer  "register_id",                                 null: false, comment: "登録ユーザーID"
    t.datetime "published_at",                                             comment: "公開日時"
    t.datetime "started_at",                                               comment: "開始日時"
    t.datetime "ended_at",                                                 comment: "終了日時"
    t.string   "venue",                                                    comment: "会場"
    t.integer  "entry_upper_limit",                                        comment: "人数上限"
    t.integer  "status",                          default: 0, null: false, comment: "ステータス(0:非公開, 1:公開, 2:満員, 3:終了, 9:中止)"
    t.datetime "created_at",                                               comment: "レコード作成日時"
    t.datetime "updated_at",                                               comment: "レコード更新日時"
    t.index ["register_id"], name: "events_register_id_fk", using: :btree
  end

  create_table "events_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", comment: "イベント-タグ" do |t|
    t.integer "event_id", null: false, comment: "イベントID"
    t.integer "tag_id",   null: false, comment: "タグID"
    t.index ["event_id", "tag_id"], name: "index_events_tags_on_event_id_tag_id", unique: true, using: :btree
    t.index ["tag_id"], name: "events_tags_tag_id_fk", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT", comment: "タグ" do |t|
    t.string   "name",       null: false, comment: "タグ名"
    t.datetime "created_at",              comment: "レコード作成日時"
    t.datetime "updated_at",              comment: "レコード更新日時"
  end

  add_foreign_key "comments", "events", name: "comments_event_id_fk"
  add_foreign_key "entries", "events", name: "entries_event_id_fk"
  add_foreign_key "events_tags", "events", name: "events_tags_event_id_fk"
  add_foreign_key "events_tags", "tags", name: "events_tags_tag_id_fk"
end
