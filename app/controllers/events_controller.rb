class EventsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_event, only: %i(show update destroy)

  def show
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
      head :bad_request
    end
  end

  def update
    if @event.update(event_params)
      render :show, status: :ok, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
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
end
