class EventsController < ApplicationController
  before_action :set_event, only: %i(show update public entry leave close destroy)
  before_action :validate_register!, only: %i(update destroy public close)

  def show
    head :not_found if @event.draft? && @event.register_id != current_user.user_id
    @users = EventUserService.list_users(@event)
    @comments = EventCommentService.list_comments(@event,@users)
  end

  def create
    @event = Event.new(event_params)
    @event.register_id = current_user.user_id
    @event.tags << Tag.find(tag_params)
    if @event.valid?
      @event.save
      render json: @event
    else
      head :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      @users = EventUserService.list_users(@event)
      @comments = EventCommentService.list_comments(@event,@users)
      render :show
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
  end

  def search
    search = Search::Event.new(keyword: params[:keyword], started_at: params[:started_at], ended_at: params[:ended_at])
    @page = params[:page]
    @per = params[:per]
    @events = search.matches.page(@page).per(@per)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.permit(Event::PERMITTED_ATTRIBUTES)
  end

  def tag_params
    params.fetch(:tags, {})
  end

  def validate_register!
    head :forbidden unless @event.register_id == current_user.user_id
  end
end
