class InitialSchema < ActiveRecord::Migration[5.0]
  def change
    create_table 'events', comment: "イベント" do |t|
      t.string 'title', null: false, comment: "タイトル"
      t.text 'body', null: false, comment: "内容"
      t.integer 'owner_id', null: false, comment: "登録ユーザーID"
      t.date 'start_date', null: false, comment: "開催日"
      t.boolean 'is_public', null: false, default: false, comment: "公開フラグ"
      t.string 'image', null: false, comment: "イベント画像path"
      t.timestamps
    end

    create_table 'comments', comment: "コメント" do |t|
      t.text 'body', null: false, comment: "コメント内容"
      t.references :event, null: false, comment: "イベントID"
      t.integer :user_id, null: false, comment: "ユーザID"
      t.timestamp 'posted_at', null: false, comment: "投稿日時"
      t.timestamps

      t.foreign_key :events, column: 'event_id', name: 'comments_event_id_fk'
    end

    create_table 'entries', comment: "参加" do |t|
      t.references :event, null: false, comment: "イベントID"
      t.integer :user_id, null: false, comment: "ユーザID"
      t.timestamps

      t.index %i(event_id user_id), name: 'index_entries_on_event_id_user_id', unique: true
      t.foreign_key :events, column: 'event_id', name: 'entries_event_id_fk'
    end
  end
end
