json.title @event.title
json.tags @event.tags.map(&:name)
json.body @event.body
json.register do
  json.name @users["register"].first.name
  json.number @users["register"].first.number
  json.college do
    json.code @users["register"].first.college.code
    json.name @users["register"].first.college.name
  end
end
json.started_at @event.started_at
json.ended_at @event.ended_at
json.venue @event.venue
json.entry_upper_limit @event.entry_upper_limit
json.status @event.status
json.entries(@users["entries"]) do |user|
  json.name user.name
  json.number user.number
  json.college do
    json.code user.college.code
    json.name user.college.name
  end
end
json.comments(@comments) do |comment|
  json.body comment["body"]
  json.posted_at comment["posted_at"]
  json.user do
    json.name comment["user"].name
    json.number comment["user"].number
    json.college do
      json.code comment["user"].college.code
      json.name comment["user"].college.name
    end
  end
end
