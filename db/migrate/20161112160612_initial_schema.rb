class InitialSchema < ActiveRecord::Migration[5.0]
  def change
    create_table 'events', comment: "イベント" do |t|
      t.string 'title', null: false, comment: "タイトル"
      t.text 'body', comment: "内容"
      t.integer 'register_id', null: false, comment: "登録ユーザーID"
      t.timestamp 'started_at', null: true, comment: "開始日時"
      t.timestamp 'ended_at', null: true, comment: "終了日時"
      t.string 'venue', null: true, comment: "会場"
      t.integer 'entry_upper_limit', null: true, comment: "人数上限"
      t.integer 'status', null: false, default: 0, comment: "ステータス(0:非公開(下書き), 1:公開/受付中, 2:満員, 3:受付終了)"
      t.string 'image', comment: "イベント画像"
      t.timestamps
    end

    create_table 'comments', comment: "コメント" do |t|
      t.text 'body', null: false, comment: "コメント内容"
      t.references :event, null: false, comment: "イベントID"
      t.references :user, null: false, comment: "ユーザID"
      t.timestamp 'posted_at', null: false, comment: "投稿日時"
      t.timestamps

      t.foreign_key :events, column: 'event_id', name: 'comments_event_id_fk'
      t.foreign_key :events, column: 'user_id', name: 'comments_user_id_fk'
    end

    create_table 'entries', comment: "参加" do |t|
      t.references :event, null: false, comment: "イベントID"
      t.references :user, null: false, comment: "ユーザID"
      t.timestamps

      t.index %i(event_id user_id), name: 'index_entries_on_event_id_user_id', unique: true
      t.foreign_key :events, column: 'event_id', name: 'entries_event_id_fk'
    end
  end
end
