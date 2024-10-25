# frozen_string_literal: true

# Controller for model Messages
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @carpool = Carpool.find(params[:carpool_id])
    unless current_user.in_carpool(@carpool)
      flash[:alert] = "You can't go there"
      redirect_to root_path
    end
    @messages = @carpool.messages
    @message = Message.new
    session[:carpool_id] = params[:carpool_id]
  end

  def create
    @message = Message.new(message_params)
    @message.update(user_id: current_user.id, carpool_id: session[:carpool_id])
    @message.save
    redirect_to new_carpool_message_path(@message.carpool_id)
    # SendMessageJob.perform_later(@message)
  end

  private

  def message_params
    params.require(:message).permit(:message_text)
  end
end
