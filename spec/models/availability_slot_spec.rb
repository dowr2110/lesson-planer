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
require 'rails_helper'

RSpec.describe AvailabilitySlot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
