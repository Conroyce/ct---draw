class DrawController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:x] = []
    controller_store[:y] = []
    controller_store[:drag] = []
  end  

  def create
    controller_store[:x].push(message[:x])
    controller_store[:y].push(message[:y])
    controller_store[:drag].push(message[:drag])
    trigger_success [controller_store[:x],controller_store[:y],controller_store[:drag]]
  end  
end
