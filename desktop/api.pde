
void send(String action, JSONObject jb) {
  JSONObject request = new JSONObject();
  request.put("action", action);
  request.put("data", jb);

  client.publish(MQTT_topic, request.toString());
}

void doRegister(String restaurantName, Menu menu) {
  JSONObject restaurantSingle = new JSONObject();
  restaurantSingle.put("resID", "");
  restaurantSingle.put("resName", restaurantName);
  restaurantSingle.put("menuSize", menu.size());
  restaurantSingle.put("menu", menu.toJson());

  JSONObject request = new JSONObject();
  request.put("conID", (int)random(1, 1000));
  request.put("queryID", 30);
  request.put("listSize", 0);
  request.put("resList", new JSONArray());
  request.put("restaurantSingle", restaurantSingle);

  client.publish(MQTT_topic_web, request.toString());
}

void doDelete(int index) {
  JSONObject data = new JSONObject();
  data.put("index", index);

  send("delete", data);
}

void doAdd(Food f) {
  JSONObject data = new JSONObject();
  data.put("food", f.toJson());

  send("add", data);
}

void doUpdate(int index, Food f) {
  JSONObject data = new JSONObject();
  data.put("index", index);
  data.put("food", f.toJson());

  send("update", data);
}
