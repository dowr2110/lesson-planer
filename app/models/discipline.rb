# == Schema Information
#
# Table name: disciplines
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_disciplines_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
class Discipline < ApplicationRecord
  belongs_to :category
  has_many :teacher_disciplines, dependent: :destroy
  has_many :teacher_profiles, through: :teacher_disciplines

  validates :name, presence: true, uniqueness: { scope: :category_id }
end
