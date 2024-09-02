# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for "chat_#{params[:chat_id]}"
  end

  def unsubscribed; end

  def send_message(data)
    message = Message.create!(content: data['message'], user_id: current_user.id, chat_id: params[:chat_id])
    ActionCable.server.broadcast("chat_#{params[:chat_id]}", message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
