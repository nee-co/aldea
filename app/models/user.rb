# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ApplicationRecord
  has_many :register_events, class_name: 'Event', foreign_key: 'register_id'
  has_many :comments, dependent: :nullify
  has_many :entries, dependent: :delete_all
  has_many :entry_events, through: :entries, source: 'event'
end