# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_teacher_status

  def show
    @chat = Chat.find(params[:id])
    authorize @chat

    @current_user = current_user
    @messages = @chat.messages.where('created_at >= ?', 1.week.ago).order(created_at: :asc)
  end

  def create
    new_chat = Chat.new(chat_params)
    authorize new_chat

    @chat = Chat.create!(chat_params)

    redirect_to @chat
  end

  private

  def chat_params
    params.require(:chat).permit(:student_id, :teacher_id)
  end
end
