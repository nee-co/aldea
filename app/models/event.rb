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
#  status            :integer          default(0), not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Event < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_and_belongs_to_many :tags

  scope :title_like, -> word {
    where("title like '%" + word + "%'")
  }
end
