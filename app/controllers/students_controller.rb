# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student

  private

  def set_student
    @student = User.find(params[:id])
  end
end
