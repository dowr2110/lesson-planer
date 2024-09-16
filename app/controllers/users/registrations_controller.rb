# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role, :name])
    end

    def after_sign_up_path_for(_)
      if current_user.teacher?
        new_teacher_profile_path
      else
        root_path
      end
    end
  end
end
