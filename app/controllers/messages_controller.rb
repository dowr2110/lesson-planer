# frozen_string_literal: true

class MessagesController < ApplicationController
  def search
    @chat = Chat.find(params[:chat_id])
    # authorize @chat

    @messages = if params[:query].present?
                  @chat.messages.search(params[:query]).records
                else
                  @chat.messages.order(created_at: :asc)
                end

    respond_to do |format|
      format.js
    end
  end
end
