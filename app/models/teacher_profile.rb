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
class TeacherProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  has_many :teacher_disciplines, dependent: :destroy
  has_many :disciplines, through: :teacher_disciplines

  has_paper_trail

  enum status: %i[verification_pending updated verified declined]

  scope :listable, -> { where(status: %i[updated verified]) }

  def status_update
    if status == 'verified'
      updated!
    else
      verification_pending!
    end
  end

  def publish
    verified!
  end
end
