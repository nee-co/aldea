json.extract! @event, :title, :body, :published_at, :started_at, :ended_at, :venue, :status
json.register_name @event.register.name
json.entry_users @event.entry_users.map(&:name)
json.tags @event.tags.map(&:name)
json.comments do
  json.array!(@event.comments) do |comment|
    json.user_name comment.user.name
    json.body comment.body
    json.posted_at comment.posted_at
  end
end
