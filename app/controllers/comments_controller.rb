class CommentsController < ApplicationController
  before_action :set_event, only: :create

  def create
    head :forbidden and return if @event.draft?
    @event.comments.create(
      body: params[:comment],
      user_id: current_user.user_id,
      posted_at: DateTime.current
    )
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
