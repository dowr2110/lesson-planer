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
end
