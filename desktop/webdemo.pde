import mqtt.*;
import controlP5.*;

String MQTT_topic_web = "Smart_menu";

ControlP5 cp5;
MQTTClient client;
Textarea text;

void setup() {
  cp5 = new ControlP5(this);
  size(900, 700);

  // connect to the broker
  client = new MQTTClient(this);
  // connect to the broker and use a random string for clientid
  client.connect("mqtt://try:try@broker.hivemq.com", "processing_web" + str(random(3)));
  delay(100);

  final PFont font = createFont("Times", 23);
  text = cp5.addTextarea("text")
    .setFont(font)
    .setPosition(10, 10)
    .setSize(800, 650);
}

void clientConnected() {
  println("client connected to broker");
  client.subscribe(MQTT_topic_web);
}

void connectionLost() {
  println("connection lost");
}

void messageReceived(String topic, byte[] payload) {
  
  JSONObject json = parseJSONObject(new String(payload));

  int queryID = json.getInt("queryID");
  JSONObject restaurantSingle = json.getJSONObject("restaurantSingle");
  
  if (queryID == 30) {
      println("JSON Received:\n" + json.toString());
      text.setText(text.getText() + "\n\nJSON Received:\n" + json.toString());
  
    //register
    String resID = "ek01";
    restaurantSingle.put("resID", resID);
    json.put("restaurantSingle",restaurantSingle);
    json.put("queryID", 31);
    
    client.publish(MQTT_topic_web, json.toString());

    println("JSON Send:\n" + json.toString());
    text.setText(text.getText() + "\n\nJSON Send:\n" + json.toString());
  } else if (queryID == 40) {
    //update menu
     println("JSON Received:\n" + json.toString());
     text.setText(text.getText() + "\n\nJSON Received:\n" + json.toString());
  }
}

// we don't really use the draw function as controlP5 does the work
void draw() {
  background(0);
}
