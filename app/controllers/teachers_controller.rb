# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :authenticate_user!

  def index
    @teachers = User.where(role: :teacher)
  end

  def assign_student
    student = User.find(params[:id])
    teacher = User.find(params[:teacher_id])
    if student.teachers.include?(teacher)
      flash[:notice] = 'Teacher is already assigned.'
    else
      student.teachers << teacher
      Chat.create(student: student, teacher: teacher)

      flash[:notice] = 'Teacher assigned successfully.'
    end
    redirect_to teachers_path
  end
end
