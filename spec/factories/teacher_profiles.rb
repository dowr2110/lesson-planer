# == Schema Information
#
# Table name: teacher_profiles
#
#  id             :bigint           not null, primary key
#  experience     :text
#  specialization :string
#  status         :integer          default("verification_pending")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_teacher_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :teacher_profile do
    user { nil }
    specialization { "MyString" }
    experience { "MyText" }
  end
end
