# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ApplicationRecord
  has_and_belongs_to_many :events

  scope :name_like,-> word {
    where("name like '%" + word + "%'")
  }
end
