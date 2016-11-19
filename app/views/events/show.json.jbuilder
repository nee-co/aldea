json.extract! @event, *%i(id title body published_at started_at ended_at venue entry_upper_limit status image)
json.register @users.register, partial: 'user', as: :user
json.entries @users.entries, partial: 'user', as: :user

json.comments(@comments) do |comment|
  json.extract! comment, *%i(body posted_at)
  json.user comment.user, partial: 'user', as: :user
end
