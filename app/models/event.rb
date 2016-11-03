# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  body              :text(65535)      not null
#  register_id       :integer          not null
#  published_at      :datetime
#  started_at        :datetime
#  ended_at          :datetime
#  venue             :string(255)
#  entry_upper_limit :integer
#  status            :integer          default("draft"), not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Event < ApplicationRecord
  enum status: { draft: 0, published: 1, full: 2, closed: 3 }

  PERMITTED_ATTRIBUTES = %i(title body venue started_at ended_at entry_upper_limit).freeze
  PUBLIC_REQUIRED_ATTRIBUTES = %i(title body venue started_at ended_at).freeze

  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_and_belongs_to_many :tags

  validates :title, presence: true

  scope :title_like, -> word {
    where(Event.arel_table[:title].matches("%#{word}%"))
  }

  scope :body_like, -> word {
    where(Event.arel_table[:body].matches("%#{word}%"))
  }

  scope :keyword_like, -> word {
    joins(:tags).merge(Tag.name_like(word).or(Event.title_like(word).or(Event.body_like(word))))
  }

  scope :started_between, -> started_at {
    date = started_at.to_date
    where(Event.arel_table[:started_at].in((date.beginning_of_day)..(date.end_of_day)))
  }

  scope :ended_between, -> ended_at {
    date = ended_at.to_date
    where(Event.arel_table[:ended_at].in((date.beginning_of_day)..(date.end_of_day)))
  }

  scope :yet, -> {
    where.not(status: :closed).or(Event.where(status: :closed).where(Event.arel_table[:ended_at].gteq Date.current))
  }

  scope :active, -> {
    where(status: %i(published full)).or(Event.closed.where(Event.arel_table[:started_at].gteq Date.current))
  }

  scope :entries_by_user, -> user_id {
    joins(:entries).merge(Entry.where(user_id: user_id))
  }

  def publishable?
    self.draft? && Event::PUBLIC_REQUIRED_ATTRIBUTES.all?(&self.method(:send))
  end

  def users
    entries_ids = entries.pluck(:user_id)
    comment_user_ids = comments.pluck(:user_id)
    user_ids = [register_id, entries_ids, comment_user_ids].flatten.uniq
    users = Cuenta::User.list(user_ids: user_ids).users

    users = OpenStruct.new(
      register: users.find { |u| u.user_id == register_id },
      entries: users.select { |u| entries_ids.include?(u.user_id) },
      comment_users: users.select { |u| comment_user_ids.include?(u.user_id) }
    )
  end
end
