class EventUserService
  def initialize(event)
  end

  def self.list_users(event)
    register_id = event.register_id
    entries_ids = event.entries.ids
    comment_users_ids = event.comments.pluck(:user_id)
    user_number = []
    user_number.push(register_id).push(entries_ids).push(comment_users_ids).flatten!
    users = Cuenta::User.list(user_ids: user_number)

    register = []
    entries = []
    comment_users = []
    for user in users["users"] do
      if register_id == user.user_id then
        register.push(user)
      end
      if entries_ids.include?(user.user_id) then
        entries.push(user)
      end
      if comment_users_ids.include?(user.user_id) then
        comment_users.push(user)
      end
    end
    users = Hash.new
    users.store("register",register)
    users.store("entries",entries)
    users.store("comment_users",comment_users)

    users
  end
end
