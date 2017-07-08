class HomeMessagesChannel < ApplicationCable::Channel  
  def subscribed
    stream_from "home_messages_#{current_user.id}"
  end
end 