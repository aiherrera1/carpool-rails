# frozen_string_literal: true

# Class that send messages
class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )

    ActionCable.server.broadcast "room_channel_#{message.carpool.id}", html: html
  end
end
