class CommentsController < ApplicationController
  before_action :set_event, only: :create

  def create
    head :not_found and return if !@event.is_public && !@event.owner?(current_user) && !@event.entry?(current_user)
    comment = @event.comments.build(
      body: params[:body],
      user_id: current_user.id,
      posted_at: DateTime.current
    )

    head :unprocessable_entity unless comment.save
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
