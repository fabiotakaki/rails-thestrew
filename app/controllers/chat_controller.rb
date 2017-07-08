class ChatController < ApplicationController
  def index
    @users = User.all.where.not(id: current_user)
    @conversations = Conversation.where('sender_id=? OR recipient_id=?', current_user.id, current_user.id)
    @conversation = Conversation.find_by(sender: current_user.id, recipient: params[:recipient])
    @message = Message.new
  end
end
