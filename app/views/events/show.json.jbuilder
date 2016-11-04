json.event_id @event.id
json.event_image @event.image_url
json.extract! @event, *%i(title body published_at started_at ended_at venue entry_upper_limit status)
json.tags @event.tags.map(&:name)
json.register @users.register, partial: 'user', as: :user
json.entries @users.entries, partial: 'user', as: :user

json.comments(@comments) do |comment|
  json.extract! comment, *%i(body posted_at)
  json.user comment.user, partial: 'user', as: :user
end
