
void send(String action, JSONObject jb) {
  JSONObject request = new JSONObject();
  request.put("action", action);
  request.put("data", jb);

  client.publish(MQTT_topic, request.toString());
}

void doRegister(String restaurantName, Menu menu) {
  JSONObject data = new JSONObject();
  data.put("name", restaurantName);
  data.put("menu", menu.toJson());

  send("register", data);
}

void doAdd(){
  
}

void doDelete(){
  
}

void doUpdate(){
  
}
