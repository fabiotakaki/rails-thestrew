class ConversationsController < ApplicationController

  def show
    @conversation = Conversation.find_by(id: params[:id])
    @users = User.all.where.not(id: current_user)
    @message = Message.new
  end
end