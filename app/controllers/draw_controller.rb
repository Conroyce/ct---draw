class DrawController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:message_count] = 0
  end  

  def create
    binding.pry
    # draw = Draw.new message
    new_message = {:message => 'this is a message'}
    send_message :returnDraw, new_message
    # if draw.save
    #   send_message :create_success, draw
    # else 
    #   send_message :create, new_message 
    # end   
  end  
end
