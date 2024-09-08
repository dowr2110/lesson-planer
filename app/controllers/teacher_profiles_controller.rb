# frozen_string_literal: true

class TeacherProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher_profile, only: %i[edit update]

  def new
    @teacher_profile = current_user.build_teacher_profile
  end

  def create
    @teacher_profile = current_user.build_teacher_profile(teacher_profile_params)
    if @teacher_profile.save
      flash[:notice] = 'Profile was successfully created.'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was an error creating the profile.'
      render :new
    end
  end

  def edit; end

  def update
    if @teacher_profile.update(teacher_profile_params)
      flash[:notice] = 'Profile was successfully updated.'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was an error updating the profile.'
      render :edit
    end
  end

  private

  def set_teacher_profile
    @teacher_profile = current_user.teacher_profile
  end

  def teacher_profile_params
    params.require(:teacher_profile).permit(:specialization, :experience, :avatar, discipline_ids: [])
  end
end
