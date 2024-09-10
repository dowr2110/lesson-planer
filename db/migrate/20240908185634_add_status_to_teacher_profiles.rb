class AddStatusToTeacherProfiles < ActiveRecord::Migration[7.1]
  def change
    add_column :teacher_profiles, :status, :integer, default: 0
  end
end
