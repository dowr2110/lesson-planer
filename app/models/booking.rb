# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id                   :bigint           not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  availability_slot_id :bigint           not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_bookings_on_availability_slot_id  (availability_slot_id)
#  index_bookings_on_user_id               (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (availability_slot_id => availability_slots.id)
#  fk_rails_...  (user_id => users.id)
#
class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :availability_slot

  # validate :slot_availability
  #
  # private
  #
  # def slot_availability
  #   errors.add(:availability_slot, 'is already booked') if availability_slot.booking.present?
  # end
end
