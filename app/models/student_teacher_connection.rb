# == Schema Information
#
# Table name: student_teacher_connections
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#  teacher_id :bigint           not null
#
# Indexes
#
#  index_student_teacher_connections_on_student_id                 (student_id)
#  index_student_teacher_connections_on_student_id_and_teacher_id  (student_id,teacher_id) UNIQUE
#  index_student_teacher_connections_on_teacher_id                 (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#  fk_rails_...  (teacher_id => users.id)
#
class StudentTeacherConnection < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :teacher, class_name: 'User'
end
