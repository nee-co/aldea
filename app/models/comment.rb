# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text(65535)      not null
#  event_id   :integer          not null
#  user_id    :integer          not null
#  posted_at  :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#
# Foreign Keys
#
#  comments_event_id_fk  (event_id => events.id)
#  comments_user_id_fk   (user_id => users.id)
#

class Comment < ApplicationRecord
  belongs_to :event
end
