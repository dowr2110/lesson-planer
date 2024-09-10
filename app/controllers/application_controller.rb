# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def check_teacher_status
    if (user_signed_in? && current_user.teacher?) && (current_user.teacher_profile&.verification_pending? || current_user.teacher_profile.nil?)
      redirect_to root_path, alert: 'Ваш профиль ещё не одобрен администратором.'
    end
  end

  def user_not_authorized
    flash[:alert] = 'У вас нет доступа к этой странице.'
    redirect_to(request.referer || root_path)
  end
end
