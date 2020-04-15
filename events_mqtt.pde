
String MQTT_topic = "food_orders";

void clientConnected() {
    println("client connected to broker");
    client.subscribe(MQTT_topic);
}

void connectionLost() {
    println("connection lost");
}

void messageReceived(String topic, byte[] payload) {
    println("Message Received: " + topic);
    
    JSONObject json = parseJSONObject(new String(payload));
    if (json == null) {
        println("Json could not be parsed");
    } else {
      println(json.toString());
      String action = json.getString("action");
      JSONObject data = json.getJSONObject("data");
      
      if(action.equals("register")){
        //register
        
        Restaurant res = new Restaurant(data.getString("name"), "restaurant" + random(1, 100));
        saveJSONObject(res.toJson(), pathRestaurant);
        
        Menu m = new Menu(data.getJSONArray("menu"));
        saveJSONArray(m.toJson(), pathMenu);
        
        view.toView(ViewType.OrderList);
        view.update();
      }else if(action.equals("add")){
        //add order
        
      }
    }
}
