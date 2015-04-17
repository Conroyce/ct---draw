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

    broadcast_message :createDraw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag)]
  end  

  def show
    broadcast_message :createDraw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag)]
  end  

  def clear
    controller_store[:x] = []
    controller_store[:y] = []
    controller_store[:drag] = []
  end  
end
