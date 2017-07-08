class ChatController < ApplicationController
  def index
    @conversations = Conversation.where('sender_id=? OR recipient_id=?', current_user.id, current_user.id)
    @message = Message.new
  end

  def new
    @users = User.all.where.not(id: current_user).map{|s| [s.email, s.id]}
  end

  def create
    recipient = User.find(params[:recipient_id])
    conversation = Conversation.where('sender_id=? and recipient_id=? OR sender_id=? and recipient_id=?', current_user.id, params[:recipient_id].to_i, params[:recipient_id].to_i, current_user.id)
    conversation = conversation.first

    if conversation.nil?
      conversation = Conversation.new({sender: current_user, recipient: recipient})
      conversation.save

      message = Message.new({user: current_user, body: params[:body], conversation_id: conversation.id})

      if message.save
        ActionCable.server.broadcast "messages_#{recipient.id}",
          message: message.body,
          user: message.user.email

        ActionCable.server.broadcast "conversations_#{recipient.id}",
          conversation: conversation.id,
          user: current_user.email,
          role: current_user.role,
          exist: false
      end
    else

      message = Message.new({user: current_user, body: params[:body], conversation_id: conversation.id})
      if message.save
        ActionCable.server.broadcast "messages_#{recipient.id}",
          message: message.body,
          user: message.user.email

        ActionCable.server.broadcast "conversations_#{recipient.id}",
          conversation: conversation.id,
          user: current_user.email,
          role: current_user.role,
          exist: true
      end

    end

    redirect_to conversation_path(conversation.id)
  end

  private
  def chat_params
    params.require(:chat).permit(:body, :recipient_id)
  end
end
