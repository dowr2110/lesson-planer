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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
