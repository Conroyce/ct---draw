class ChatController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:message_count] = 0
  end

  def create
    binding.pry
    chat = Chat.new message
    if chat.save
      send_message :create_success, task, :namespace => :chats
    else
      send_message :create_fail, task, :namespace => :tasks
    end
  end      
  
  def text
    new_message = {:message => 'this is a message'}
    send_message :event_name, new_message
  end  
end
