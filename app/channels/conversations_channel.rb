class ConversationsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "conversations_#{current_user.id}"
  end
end 