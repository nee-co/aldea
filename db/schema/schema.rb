create_table "ar_internal_metadata", collate: "utf8_general_ci", comment: "AR_メタデータ" do |t|
  t.varchar "key", primary_key: true, comment: "キー"
  t.varchar "value", null: true, comment: "バリュー"
  t.datetime "created_at", null: true, comment: "レコード作成日時"
  t.datetime "updated_at", null: true, comment: "レコード更新日時"
end

create_table "comments", collate: "utf8_general_ci", comment: "コメント" do |t|
  t.int "id", primary_key: true, extra: "auto_increment", comment: "ID"
  t.text "body", comment: "コメント内容"
  t.int "event_id", comment: "イベントID"
  t.int "user_id", comment: "ユーザーID"
  t.datetime "posted_at", comment: "投稿日時"
  t.datetime "created_at", null: true, comment: "レコード作成日時"
  t.datetime "updated_at", null: true, comment: "レコード更新日時"

  t.foreign_key "event_id", reference: "events", reference_column: "id", name: "comments_event_id_fk"
end

create_table "entries", collate: "utf8_general_ci", comment: "参加" do |t|
  t.int "id", primary_key: true, extra: "auto_increment", comment: "ID"
  t.int "event_id", comment: "イベントID"
  t.int "user_id", comment: "ユーザーID"
  t.datetime "created_at", null: true, comment: "レコード作成日時"
  t.datetime "updated_at", null: true, comment: "レコード更新日時"

  t.index ["event_id", "user_id"], name: "index_entries_on_event_id_user_id", unique: true
  t.foreign_key "event_id", reference: "events", reference_column: "id", name: "entries_event_id_fk"
end

create_table "events", collate: "utf8_general_ci", comment: "イベント" do |t|
  t.int "id", primary_key: true, extra: "auto_increment", comment: "ID"
  t.varchar "title", comment: "タイトル"
  t.text "body", comment: "内容"
  t.int "register_id", comment: "登録ユーザーID"
  t.datetime "published_at", null: true, comment: "公開日時"
  t.datetime "started_at", null: true, comment: "開始日時"
  t.datetime "ended_at", null: true, comment: "終了日時"
  t.varchar "venue", null: true, comment: "会場"
  t.int "entry_upper_limit", null: true, comment: "人数上限"
  t.int "status", default: 0, comment: "ステータス(0:非公開(下書き), 1:公開/受付中, 2:満員, 3:受付終了)"
  t.varchar "image", comment: "イベント画像"
  t.datetime "created_at", null: true, comment: "レコード作成日時"
  t.datetime "updated_at", null: true, comment: "レコード更新日時"
end

create_table "events_tags", collate: "utf8_general_ci", comment: "イベント-タグ" do |t|
  t.int "event_id", comment: "イベントID"
  t.int "tag_id", comment: "タグID"

  t.index ["event_id", "tag_id"], name: "index_events_tags_on_event_id_tag_id", unique: true
  t.foreign_key "tag_id", reference: "tags", reference_column: "id", name: "events_tags_tag_id_fk"
  t.foreign_key "event_id", reference: "events", reference_column: "id", name: "events_tags_event_id_fk"
end

create_table "schema_migrations", collate: "utf8_general_ci", comment: "" do |t|
  t.varchar "version", primary_key: true
end

create_table "tags", collate: "utf8_general_ci", comment: "タグ" do |t|
  t.int "id", primary_key: true, extra: "auto_increment", comment: "ID"
  t.varchar "name", comment: "タグ名"
  t.datetime "created_at", null: true, comment: "レコード作成日時"
  t.datetime "updated_at", null: true, comment: "レコード更新日時"
end
