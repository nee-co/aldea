class Event < ApplicationRecord
  belongs_to :register, class_name: 'User'
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :entry_users, through: :entries, source: 'user'
  has_and_belongs_to_many :tags
end
