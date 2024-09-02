class CreateTeacherProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :teacher_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :specialization
      t.text :experience

      t.timestamps
    end
  end
end
