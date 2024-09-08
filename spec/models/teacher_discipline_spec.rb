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
require 'rails_helper'

RSpec.describe TeacherDiscipline, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
