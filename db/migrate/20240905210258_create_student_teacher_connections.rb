# frozen_string_literal: true

class CreateStudentTeacherConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :student_teacher_connections do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :teacher, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :student_teacher_connections, %i[student_id teacher_id], unique: true
  end
end
