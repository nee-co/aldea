class EventCommentService
  def initialize(event)
  end

  def self.list_comments(event, users)
    comments = event.comments
    comments_list = []
    for comment in comments do
      work = Hash.new
      for user in users["comment_users"] do
        if comment["user_id"] == user["user_id"]
          work.store("body",comment.body)
          work.store("posted_at",comment.posted_at)
          work.store("user",user)
        end
      end
      comments_list.push(work)
    end

    comments_list
  end
end
