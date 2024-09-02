class CreateStudentProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :student_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :level_of_knowledge
      t.text :interests

      t.timestamps
    end
  end
end
