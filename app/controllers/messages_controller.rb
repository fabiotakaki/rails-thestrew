class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    message.user = current_user
    message.conversation = Conversation.find(message_params[:conversation_id])
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.body,
        user: message.user.email
      head :ok
    else 
      redirect_to conversation_path
    end
  end

  private

    def message_params
      params.require(:message).permit(:body, :recipient, :conversation_id)
    end
end