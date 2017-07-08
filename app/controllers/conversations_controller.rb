class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find_by(id: params[:id])
    @users = User.all.where.not(id: current_user)
    @message = Message.new
  end

  def create
    conversation = Conversation.new(conversation_params)
    conversation.sender = current_user
    message
  end

  private
  def conversation_params
    params.require(:conversation).permit(:recipient_id)
  end
end