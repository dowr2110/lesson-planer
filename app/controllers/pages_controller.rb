class PagesController < ApplicationController
  def home
    if current_user.teacher?
      @profile = current_user.teacher_profile
    elsif current_user.student?
      @profile = current_user.student_profile
    end
  end
end
