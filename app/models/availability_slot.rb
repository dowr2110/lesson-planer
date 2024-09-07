# frozen_string_literal: true

# == Schema Information
#
# Table name: availability_slots
#
#  id         :bigint           not null, primary key
#  end_time   :datetime
#  meet_link  :string
#  start_time :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher_id :bigint           not null
#
# Indexes
#
#  index_availability_slots_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => users.id)
#
class AvailabilitySlot < ApplicationRecord
  belongs_to :teacher, class_name: 'User'
  has_one :booking, dependent: :destroy

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  scope :free, -> { left_outer_joins(:booking).where(bookings: { id: nil }) }
  scope :available, -> { where('start_time >= ?', Time.current) }

  def booked?
    !booking.nil?
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, 'must be after the start time') if end_time <= start_time
  end
end
