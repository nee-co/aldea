# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  event_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Foreign Keys
#
#  entries_event_id_fk  (event_id => events.id)
#  entries_user_id_fk   (user_id => users.id)
#

class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
