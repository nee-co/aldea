class CommentsController < ApplicationController
  before_action :set_event, only: :create

  def create
    head :forbidden and return if @event.draft?
    comment = @event.comments.build(
      body: params[:body],
      user_id: current_user.user_id,
      posted_at: DateTime.current
    )
    if comment.valid?
      comment.save
    else
      head :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
