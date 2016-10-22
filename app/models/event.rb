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

  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_and_belongs_to_many :tags

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
end
