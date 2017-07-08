class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.user = current_user

    conversation = Conversation.find(message_params[:conversation_id])
    message.conversation = conversation
    if message.save
      ActionCable.server.broadcast "home_messages_#{conversation.recipient.id}",
        message: message.body,
        user: message.user.email
      head :ok

      ActionCable.server.broadcast "messages_#{conversation.recipient.id}",
        message: message.body,
        user: message.user.email
      head :ok

      ActionCable.server.broadcast "messages_#{conversation.sender.id}",
        message: message.body,
        user: message.user.email
      head :ok
    else 
      redirect_to conversation_path(conversation.id)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :recipient, :conversation_id)
  end
end