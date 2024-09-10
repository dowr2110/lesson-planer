# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    end

    def after_sign_up_path_for(_)
      new_teacher_profile_path if current_user.teacher?
    end
  end
end
