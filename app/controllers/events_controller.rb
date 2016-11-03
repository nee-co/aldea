class EventsController < ApplicationController
  before_action :set_event, only: %i(show update public entry leave close destroy)
  before_action :validate_register!, only: %i(update destroy public close)
  before_action :validate_no_register!, only: %i(entry leave)
  before_action :set_paginated_param!, only: %i(entries own search)

  def show
    head :not_found and return if @event.draft? && @event.register_id != current_user.user_id
    @users = @event.users
    @comments = @event.comments.map do |comment|
                  OpenStruct.new(
                    body: comment.body,
                    posted_at: comment.posted_at,
                    user: @users.comment_users.find { |u| u.user_id == comment.user_id }
                  )
                end
  end

  def create
    @event = Event.new(event_params)
    @event.register_id = current_user.user_id
    @event.tags << Tag.find(tag_params)
    if @event.valid?
      @event.save
      render status: :created
    else
      head :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
    else
      head :unprocessable_entity
    end
  end

  def destroy
    head :forbidden and return unless @event.draft?
    @event.destroy
  end

  def public
    head :forbidden and return unless @event.publishable?
    @event.published!
    @event.update(published_at: DateTime.current)
  end

  def entry
    head :forbidden and return unless @event.published?
    @event.entries.create(user_id: current_user.user_id)
    @event.full! if @event.entry_upper_limit && @event.entry_upper_limit <= @event.entries.size
  rescue ActiveRecord::RecordNotUnique
    head :unprocessable_entity
  end

  def leave
    @event.entries.find_by!(user_id: current_user.user_id).destroy
    @event.published! if @event.full? && @event.entry_upper_limit && @event.entry_upper_limit > @event.entries.size
  rescue ActiveRecord::RecordNotFound
    head :forbidden and return
  end

  def close
    head :forbidden and return unless (@event.published? || @event.full?)
    @event.closed!
  end

  def entries
    @events = current_user.entry_events.active.page(@page).per(@per)
  end

  def own
    @events = current_user.registered_events.page(@page).per(@per)
  end

  def search
    search = Search::Event.new(keyword: params[:keyword], started_at: params[:started_at], ended_at: params[:ended_at])
    @events = search.matches.page(@page).per(@per)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(Event::PERMITTED_ATTRIBUTES)
  end

  def tag_params
    params.fetch(:tags, {})
  end

  def validate_register!
    head :forbidden and return unless @event.register_id == current_user.user_id
  end

  def validate_no_register!
    head :forbidden and return if @event.register_id == current_user.user_id
  end
end
