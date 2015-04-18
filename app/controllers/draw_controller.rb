class DrawController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:x] = [] #public storage
    controller_store[:y] = []
    controller_store[:drag] = []
    controller_store[:id] = 0
    controller_store[:color] = [  
      'FF0000', #red
      '#FF9933', #orange
      '#FFFF00', #yellow
      '#99FF33', #light green
      '#33CC33', #dark green
      '#66CCFF', #light blue
      '#3333CC', #dark blue
      '#CC00CC'  #purple
    ]

    if !connection_store[:id]  #private storage, check if its a new connection
      controller_store[:id] += 1
      connection_store[:id] = controller_store[:id]
      broadcast_message :setColor, controller_store[:color][connection_store[:id]]
    end  
  end   

  def create
    if !connection_store[:id]  #private storage, check if its a new connection
      controller_store[:id] += 1
      connection_store[:id] = controller_store[:id]
      broadcast_message :setColor, controller_store[:color][connection_store[:id]]
    end 

    controller_store[:x].push(message[:x])
    controller_store[:y].push(message[:y])
    controller_store[:drag].push(message[:drag])

    broadcast_message :createDraw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag)
    ]
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
