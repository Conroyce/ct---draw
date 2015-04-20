class DrawController < WebsocketRails::BaseController
  def initialize_session
    controller_store[:x] = [] #public storage
    controller_store[:y] = []
    controller_store[:drag] = []
    controller_store[:color] = []
    controller_store[:id] = 0
    controller_store[:colors] = [  
      'FF0000', #red
      '#FF9933', #orange
      '#FFFF00', #yellow
      '#99FF33', #light green
      '#33CC33', #dark green
      '#66CCFF', #light blue
      '#3333CC', #dark blue
      '#CC00CC'  #purple
    ]
  end   

  def startConnect
    controller_store[:id] += 1
    controller_store[:id] = 0 if controller_store[:id] == 8
    connection_store[:id] = controller_store[:id]

    send_message :curColor, controller_store[:colors][connection_store[:id]]

    send_message :Draw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag),
      controller_store[:color]
    ]
  end  

  def create
    controller_store[:x] << message[:x]
    controller_store[:y] << message[:y]
    controller_store[:drag] << message[:drag]
    controller_store[:color] << controller_store[:colors][connection_store[:id]]

    send_message :Draw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag),
      controller_store[:color]
    ]
  end  

  def show
    send_message :Draw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag),
      controller_store[:color]
    ]
  end  

  def clear
    controller_store[:x] = []
    controller_store[:y] = []
    controller_store[:drag] = []
    controller_store[:color] = []

    send_message :Draw, [
      controller_store.collect_all(:x),
      controller_store.collect_all(:y),
      controller_store.collect_all(:drag),
      controller_store[:color]
    ]
  end  
end
