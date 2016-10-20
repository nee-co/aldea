class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events/1
  def show
    @users = EventUserService.list_users(@event)
    @comments = EventCommentService.list_comments(@event,@users)
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render :show, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render :show, status: :ok, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  # GET /events/search?keyword=Ruby&started_at=20160710&ended_at=20160710
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
    params.fetch(:event, {})
  end
end
