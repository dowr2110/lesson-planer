class CreateTeacherDisciplines < ActiveRecord::Migration[7.1]
  def change
    create_table :teacher_disciplines do |t|
      t.references :teacher_profile, null: false, foreign_key: true
      t.references :discipline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
