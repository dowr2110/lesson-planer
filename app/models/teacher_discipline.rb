# == Schema Information
#
# Table name: teacher_disciplines
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  discipline_id      :bigint           not null
#  teacher_profile_id :bigint           not null
#
# Indexes
#
#  index_teacher_disciplines_on_discipline_id       (discipline_id)
#  index_teacher_disciplines_on_teacher_profile_id  (teacher_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (discipline_id => disciplines.id)
#  fk_rails_...  (teacher_profile_id => teacher_profiles.id)
#
class TeacherDiscipline < ApplicationRecord
  belongs_to :teacher_profile
  belongs_to :discipline

  validates :teacher_profile_id, uniqueness: { scope: :discipline_id }
end
