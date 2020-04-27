
String MQTT_topic = "Smart_menu_self";
String MQTT_topic_web = "Smart_menu";

void clientConnected() {
  println("client connected to broker");
  client.subscribe(MQTT_topic);
  client.subscribe(MQTT_topic_web);
}

void connectionLost() {
  println("connection lost");
}

void sendMenuToWeb() {
  Restaurant res = loadRestaurant();

  JSONObject restaurantSingle = new JSONObject();
  restaurantSingle.put("resID", res.id);
  restaurantSingle.put("resName", res.name);
  restaurantSingle.put("menuSize", menu.size());
  restaurantSingle.put("menu", menu.toJson());

  JSONObject request = new JSONObject();
  request.put("conID", (int)random(1, 1000));
  request.put("queryID", 40);
  request.put("listSize", 0);
  request.put("resList", new JSONArray());
  request.put("restaurantSingle", restaurantSingle);

  client.publish(MQTT_topic_web, request.toString());
}

void messageReceivedProcessing(String payload) {
  JSONObject json = parseJSONObject(payload);

  if (json == null) {
    println("Json could not be parsed");
  } else {
    String action = json.getString("action");
    JSONObject data = json.getJSONObject("data");

    if (action.equals("delete")) {
      //delete order
      int index = data.getInt("index");
      menu.remove(index);
      saveJSONArray(menu.toJson(), pathMenu);

      view.update();
    } else if (action.equals("add")) {
      //add order
      JSONObject foodJson = data.getJSONObject("food");
      Food f = new Food(foodJson);
      menu.addFood(f);
      saveJSONArray(menu.toJson(), pathMenu);

      view.toView(ViewType.OrderList);
      view.update();
    } else if (action.equals("update")) {
      //add order
      int index = data.getInt("index");
      JSONObject foodJson = data.getJSONObject("food");
      Food f = new Food(foodJson);
      menu.set(index, f);
      saveJSONArray(menu.toJson(), pathMenu);

      view.toView(ViewType.OrderList);
      view.update();
    }

    sendMenuToWeb();
  }
}

void messageReceivedWeb(String payload) {
  JSONObject json = parseJSONObject(payload);

  int queryID = json.getInt("queryID");
  if(queryID != 31){
     return; 
  }
  
  JSONObject restaurantSingle = json.getJSONObject("restaurantSingle");
  String resID = restaurantSingle.getString("resID");
  String resName = restaurantSingle.getString("resName");
  
  //register response
  Restaurant res = new Restaurant(resName, resID);
  saveJSONObject(res.toJson(), pathRestaurant);

  view.toView(ViewType.OrderList);
  view.update();
}

void messageReceived(String topic, byte[] payload) {
  String res = new String(payload);
  println("Message Received: " + topic);
  //println(res);

  if (topic.equals(MQTT_topic)) {
    messageReceivedProcessing(res);
  } else if (topic.equals(MQTT_topic_web)) {
    try {
      messageReceivedWeb(res);
    }
    catch(Exception e) {
      println("Can not understand: ");
      println(res);
    }
  }
}
