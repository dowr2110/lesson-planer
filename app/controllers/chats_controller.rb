# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show
    @chat = Chat.find(params[:id])
    authorize @chat

    @messages = @chat.messages.order(created_at: :asc)
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
