# frozen_string_literal: true

class StudentProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student_profile, only: %i[edit update]

  def new
    @student_profile = current_user.build_student_profile
  end

  def create
    @student_profile = current_user.build_student_profile(student_profile_params)
    if @student_profile.save
      flash[:notice] = 'Profile was successfully created.'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was an error creating the profile.'
      render :new
    end
  end

  def edit; end

  def update
    if @student_profile.update(student_profile_params)
      flash[:notice] = 'Profile was successfully updated.'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was an error updating the profile.'
      render :edit
    end
  end

  private

  def set_student_profile
    @student_profile = current_user.student_profile
  end

  def student_profile_params
    params.require(:student_profile).permit(:level_of_knowledge, :interests, :avatar)
  end
end
