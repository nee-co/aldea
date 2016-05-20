# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  title             :string(255)      not null
#  register_id       :integer          not null
#  registered_at     :datetime         not null
#  started_at        :datetime
#  ended_at          :datetime
#  venue             :string(255)
#  entry_upper_limit :integer
#  status            :integer          default(0), not null
#  created_at        :datetime
#  updated_at        :datetime
#
# Foreign Keys
#
#  events_register_id_fk  (register_id => users.id)
#

class Event < ApplicationRecord
  belongs_to :register, class_name: 'User'
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :entry_users, through: :entries, source: 'user'
  has_and_belongs_to_many :tags
end
