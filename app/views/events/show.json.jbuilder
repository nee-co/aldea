json.partial! partial: 'event', locals: { event: @event, extend: true }
json.register @users.register, partial: 'user', as: :user
json.entries @users.entries, partial: 'user', as: :user

json.comments(@comments) do |comment|
  json.extract! comment, *%i(body posted_at)
  json.user comment.user, partial: 'user', as: :user
end
