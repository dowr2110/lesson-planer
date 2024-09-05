# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("student"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[student teacher]

  has_one_attached :avatar

  has_one :teacher_profile, dependent: :destroy
  has_one :student_profile, dependent: :destroy

  accepts_nested_attributes_for :teacher_profile
  accepts_nested_attributes_for :student_profile

  has_many :bookings

  has_many :student_teacher_connections_as_student,
           foreign_key: :student_id,
           class_name: 'StudentTeacherConnection'
  has_many :teachers, through: :student_teacher_connections_as_student, source: :teacher

  has_many :student_teacher_connections_as_teacher,
           foreign_key: :teacher_id,
           class_name: 'StudentTeacherConnection'
  has_many :students, through: :student_teacher_connections_as_teacher, source: :student


  def booked_slots
    if student?
      AvailabilitySlot.joins(:booking).where(bookings: { user_id: id })
    elsif teacher?
      AvailabilitySlot.joins(:booking).where(teacher: self).where.not(bookings: { id: nil })
    end
  end
end
