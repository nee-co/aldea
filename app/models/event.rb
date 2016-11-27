# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  body              :text(65535)
#  register_id       :integer          not null
#  started_at        :datetime
#  ended_at          :datetime
#  venue             :string(255)
#  entry_upper_limit :integer
#  status            :integer          default("draft"), not null
#  image             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Event < ApplicationRecord
  enum status: { draft: 0, published: 1, full: 2, closed: 3 }

  PERMITTED_ATTRIBUTES = %i(title body venue started_at ended_at entry_upper_limit).freeze
  PUBLIC_REQUIRED_ATTRIBUTES = %i(title body venue started_at ended_at).freeze

  DEFAULT_IMAGE_PATH = 'images/events/default.png'.freeze
  ALLOW_IMAGE_EXTNAMES = %w(png jpg jpeg gif).freeze

  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all

  validates :title, presence: true

  scope :title_like, -> (word) {
    where(Event.arel_table[:title].matches("%#{word}%"))
  }

  scope :body_like, -> (word) {
    where(Event.arel_table[:body].matches("%#{word}%"))
  }

  scope :keyword_like, -> (word) {
    Event.title_like(word).or(Event.body_like(word))
  }

  scope :yet, -> {
    where.not(status: :closed).or(Event.where(status: :closed).where(Event.arel_table[:ended_at].gteq(Date.current)))
  }

  scope :active, -> {
    where(status: %i(published full)).or(Event.closed.where(Event.arel_table[:started_at].gteq(Date.current)))
  }

  scope :entries_by_user, -> (user_id) {
    joins(:entries).merge(Entry.where(user_id: user_id))
  }

  def publishable?
    draft? && Event::PUBLIC_REQUIRED_ATTRIBUTES.all?(&method(:send))
  end

  def users
    entries_ids = entries.pluck(:user_id)
    comment_user_ids = comments.pluck(:user_id)
    user_ids = [register_id, entries_ids, comment_user_ids].flatten.uniq
    users = Cuenta::User.list(user_ids: user_ids).users

    OpenStruct.new(
      register: users.find { |u| u.id == register_id },
      entries: users.select { |u| entries_ids.include?(u.id) },
      comment_users: users.select { |u| comment_user_ids.include?(u.id) }
    )
  end
end
