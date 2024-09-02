# == Schema Information
#
# Table name: student_profiles
#
#  id                 :bigint           not null, primary key
#  interests          :text
#  level_of_knowledge :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_student_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe StudentProfile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
