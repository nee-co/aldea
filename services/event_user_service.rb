class EventUserService
  def initialize(event)
  end

  def self.list_users(event)
    register = event.register_id
    entries = event.entries.ids
    comment_users = event.comments.ids
    user_number = []
    user_number.push(register).push(entries).push(comment_users).flatten!
    @users = User.list(user_number.join(' '))
  end
end
