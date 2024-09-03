class PagesController < ApplicationController
  def home
    if user_signed_in? && current_user.teacher?
      @profile = current_user.teacher_profile
    elsif user_signed_in? && current_user.student?
      @profile = current_user.student_profile
    end
  end
end
