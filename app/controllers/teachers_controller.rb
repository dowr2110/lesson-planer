# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :authenticate_user!

  def index
    @teachers = TeacherProfile.listable.joins(:user)
    @teachers = @teachers.where("users.email ILIKE ?", "%#{params[:email]}%") if params[:email].present?
    @teachers = @teachers.joins(:disciplines).where(disciplines: { id: params[:discipline_id] }) if params[:discipline_id].present?

    respond_to do |format|
      format.html
      format.js
    end
  end

  def my_students
    @my_students = current_user.students
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
