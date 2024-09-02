# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :bigint           not null
#  teacher_id :bigint           not null
#
# Indexes
#
#  index_chats_on_student_id  (student_id)
#  index_chats_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => users.id)
#  fk_rails_...  (teacher_id => users.id)
#
class Chat < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :teacher, class_name: 'User'

  has_many :messages, dependent: :destroy
end
