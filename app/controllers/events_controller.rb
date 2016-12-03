class EventsController < ApplicationController
  before_action :set_event, only: %i(show update public private entry leave destroy image)
  before_action :validate_owner!, only: %i(update destroy public private)
  before_action :validate_no_owner!, only: %i(entry leave)
  before_action :set_paginated_param!, only: %i(entries own search)

  def show
    head :not_found and return if !@event.is_public && !@event.owner?(current_user) && !@event.entry?(current_user)
    @users = @event.users
    @comments = fetch_comments
  end

  def create
    event = Event.new(event_params.merge(owner_id: current_user.id))
    if event.save
      @event = event.decorate
      render status: :created
    else
      head :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      @event = @event.decorate
    else
      head :unprocessable_entity
    end
  end

  def destroy
    head :forbidden and return if @event.entries.present?
    @event.destroy
  end

  def public
    head :forbidden and return if @event.is_public
    @event.update(is_public: true)
  end

  def private
    head :forbidden and return unless @event.is_public
    @event.update(is_public: false)
  end

  def entry
    head_4xx and return unless @event.is_public
    @event.entries.create(user_id: current_user.id)
  rescue ActiveRecord::RecordNotUnique
    head :unprocessable_entity
  end

  def leave
    @event.entries.find_by!(user_id: current_user.id).destroy
  rescue ActiveRecord::RecordNotFound
    head :not_found and return
  end

  def entries
    @events = current_user.entry_events.yet.page(@page).per(@per).decorate
    @total_count = @events.object.total_count
  end

  def own
    @events = current_user.owned_events.yet.page(@page).per(@per).decorate
    @total_count = @events.object.total_count
  end

  def search
    @events = Event.public_events.yet
                   .where.not(owner_id: current_user.id)
                   .not_entries_by_user(current_user.id)
                   .keyword_like(params[:keyword])
                   .order(:start_date)
                   .page(@page)
                   .per(@per)
                   .decorate
    @total_count = @events.object.total_count
  end

  private

  def set_event
    @event = Event.find(params[:id]).decorate
  end

  def fetch_comments
    @event.comments.map do |comment|
      OpenStruct.new(
        body: comment.body,
        posted_at: comment.posted_at,
        user: @users.comment_users.find { |u| u.id == comment.user_id }
      )
    end
  end

  def event_params
    params.permit(Event::PERMITTED_ATTRIBUTES).merge(upload_image: params.fetch(:image, {}))
  end

  def validate_owner!
    head_4xx unless @event.owner?(current_user)
  end

  def validate_no_owner!
    head :forbidden and return if @event.owner?(current_user)
  end

  def head_4xx
    if !@event.is_public && !@event.entry?(current_user)
      head :not_found
    else
      head :forbidden
    end
  end
end
