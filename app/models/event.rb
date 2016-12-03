# frozen_string_literal: true
# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :text(65535)      not null
#  owner_id   :integer          not null
#  start_date :date             not null
#  is_public  :boolean          default(FALSE), not null
#  image      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  PERMITTED_ATTRIBUTES = %i(title body start_date).freeze

  attr_accessor :upload_image

  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all

  validates :title, presence: true
  validates :body, presence: true
  validates :start_date, presence: true
  validates :owner_id, presence: true

  validate :validate_date, if: -> { errors[:start_date].empty? }
  validate :validate_upload_image, if: -> { errors.empty? && upload_image.present? }

  before_save :set_default_image, if: -> { image.nil? }
  after_destroy :remove_image

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
    where(Event.arel_table[:start_date].gteq(Date.current))
  }

  scope :public_events, -> {
    where(is_public: true)
  }

  scope :entries_by_user, -> (user_id) {
    joins(:entries).merge(Entry.where(user_id: user_id))
  }

  scope :not_entries_by_user, -> (user_id) {
    left_outer_joins(:entries).merge(Entry.where(id: nil).or(Entry.where.not(user_id: user_id)))
  }

  def entry?(user)
    entries.where(user_id: user.id).present?
  end

  def owner?(user)
    owner_id == user.id
  end

  def users
    entries_ids = entries.pluck(:user_id)
    comment_user_ids = comments.pluck(:user_id)
    user_ids = [owner_id, entries_ids, comment_user_ids].flatten.uniq
    users = Cuenta::User.list(user_ids: user_ids).users

    OpenStruct.new(
      owner: users.find { |u| u.id == owner_id },
      entries: users.select { |u| entries_ids.include?(u.id) },
      comment_users: users.select { |u| comment_user_ids.include?(u.id) }
    )
  end

  def self.default_image
    File.open(Rails.root.join('files/default.png'))
  end

  private

  def validate_date
    errors.add(:start_date) if start_date < Date.current
  end

  def validate_upload_image
    errors.add(:image) unless self.image = Imagen::Image.upload(upload_image, image_was).presence
  end

  def set_default_image
    self.image = Imagen::Image.upload(self.class.default_image)
  end

  def remove_image
    Imagen::Image.delete(image_name: image)
  end
end
