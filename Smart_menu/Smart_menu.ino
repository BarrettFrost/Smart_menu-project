#include <M5Stack.h>
#include <WiFi.h>
#include <esp_wifi.h>
#include <PubSubClient.h>
WiFiClient wifi_client;
PubSubClient ps_client( wifi_client );
#include "menu.h"
#include "List.h"
#include "Arduino.h"
#include <Preferences.h>
#include <ArduinoJson.h>

int width;
int state;
int state_new = 0;
int state_set = 1;
int state_pref = 2;
int state_rest = 3;
int state_menu = 4;
int state_order = 5;
int calorie;
int veg;
int gluten;
int allergy;
List diet[3];
List *restaur;
Menu *food;
char *JSON;
int total_cal;
int cursor_row;
const char* restaurant;
int rest_id;
int rest_size;
String rest_name;
int menu_size;
int queryID;

Preferences save;

uint8_t guestMacAddress[6] = {0xF0, 0x79, 0x60, 0x7E, 0xC9, 0x52};
const char* ssid = "Glide";                 // Set name of Wifi Network
const char* password = "";                      // No password for UoB Guest
// MQTT Settings
const char* MQTT_clientname = "Smart_menu"; // Make up a short name
const char* MQTT_sub_topic = "Smart_menu"; // pub/sub topics
const char* MQTT_pub_topic = "Smart_menu"; // You might want to create your own

// Please leave this alone - to connect to HiveMQ
const char* server = "broker.mqttdashboard.com";
const int port = 1883;

const int capacity = JSON_ARRAY_SIZE(10)
+ 3*JSON_OBJECT_SIZE(3);

StaticJsonDocument<200> doc;
DynamicJsonDocument recieve(capacity);

void setup() {
  M5.begin();
  M5.Power.begin();
  M5.Lcd.fillScreen(WHITE);
  Serial.begin(115200);
  delay(10);
  Serial.println("*** RESET ***\n");
  state = state_new;

  save.begin("data", false);
  calorie = save.getUInt("cal");
  veg = save.getUInt("veg");
  gluten = save.getUInt("gluten");
  allergy = save.getUInt("allergy");

  diet[0].intial(1, "vegan(V)", 0, veg);
  diet[1].intial(2, "gluten free(GF)", 0, gluten);
  diet[2].intial(3, "contains nuts(N)", 0, allergy);
  JSON = (char*)malloc(10000*sizeof(char));
  restaur = (List*)malloc(4*sizeof(List));
  width = 320;
  cursor_row = 1;
  setupWifi();
  setupMQTT();
}

void loop() {

  if (!ps_client.connected()) {
    reconnect();
  }
  ps_client.loop();

  switch (state) {
    case 0 :
      newmeal();
      break;
    case 1:
      set_cal();
      break;
    case 2:
      pref();
      break;
    case 3:
      rest();
      break;
    case 4:
      menu();
      break;
    case 5:
      order();
      break;
    default :
      Serial.println("Unknown state");
      break;
  }
}

void newmeal() {
  int i;
  M5.Lcd.clear(WHITE);
  for (i = 0; i < 40; i++) {
    M5.update();
    M5.Lcd.setCursor(50, 75);
    M5.Lcd.setTextColor(BLACK);
    M5.Lcd.setTextSize(5);
    M5.Lcd.printf("New meal");
    M5.Lcd.setCursor(30, 180);
    M5.Lcd.setTextSize(1);
    M5.Lcd.printf("Preferences");
    M5.Lcd.setCursor(235, 180);
    M5.Lcd.printf("Orders");
    draw_buttons();
    JSONRecieve_rest();
    if (M5.BtnA.wasReleased()) {
      state = state_set;
    }
    if (M5.BtnB.wasReleased()) {
      //state = state_rest;
      JSONPublish_rest();
    }
    delay (5);
  }
}
void JSONPublish_rest() {

  doc["queryID"] = 10;
  //  doc.printTo(Serial);
  String output;
  serializeJson(doc, output);
  publishMessage(output);
}
void JSONRecieve_rest() {
  if(queryID == 11){
    rest_size = recieve["listSize"];
    for(int i = 0; i < rest_size; i++){
      JsonObject rest = recieve["resList"][i];
      restaurant = rest["resName"];
      rest_id = rest["resID"];
      String name = String(restaurant);
      restaur[i].intial(i+1, name, rest_id, 0);
    }
    state = state_rest;
  }
}
void set_cal() {
  M5.Lcd.clear(WHITE);
  int i;
  for (i = 0; i < 40; i++) {
    M5.update();
    M5.Lcd.setCursor(20, 75);
    M5.Lcd.setTextSize(3);
    M5.Lcd.printf("Set MAX Calories");
    M5.Lcd.drawNumber(calorie, 130, 150);
    draw_buttons();
    M5.Lcd.drawFastHLine(55, 225, 20, BLACK);
    M5.Lcd.drawFastHLine(245, 225, 20, BLACK);
    M5.Lcd.drawFastVLine(255, 215, 20, BLACK);
    M5.Lcd.setCursor(140, 220);
    M5.Lcd.setTextSize(1);
    M5.Lcd.printf("Confirm");
    if (M5.BtnA.wasReleased()) {
      if (calorie != 0) {
        calorie = calorie - 50;
      }
    }
    if (M5.BtnC.wasReleased()) {
      calorie = calorie + 50;
    }
    if (M5.BtnB.wasReleased()) {
      state = state_pref;
      save.putUInt("cal", calorie);
    }
    delay (20);
  }
}
void pref() {
  M5.Lcd.clear(WHITE);
  for (int i = 0; i < 40; i++) {
    M5.update();
    display_pref();
    if (M5.BtnA.wasReleased()) {
      if (cursor_row == 1) {
        diet[0].select();
      }
      else if (cursor_row == 2) {
        diet[1].select();
      }
      else {
        diet[2].select();
      }
    }
    if (M5.BtnB.wasReleased()) {
      state = state_new;
      save.putUInt("veg", diet[0].is_selected());
      save.putUInt("gluten", diet[1].is_selected());
      save.putUInt("allergy", diet[2].is_selected());
    }
    line_cursor(3);
    delay(20);
  }
}
void display_pref() {
  M5.Lcd.setCursor(20, 20);
  M5.Lcd.setTextSize(2);
  M5.Lcd.printf("Dietary requirements");
  M5.Lcd.drawFastHLine(0, 40, width , BLACK);
  diet[0].display_item();
  diet[1].display_item();
  diet[2].display_item();
  draw_buttons();
  M5.Lcd.setTextSize(1);
  M5.Lcd.setCursor(140, 220);
  M5.Lcd.printf("Save");
  M5.Lcd.setCursor(45, 220);
  M5.Lcd.printf("Select");
  M5.Lcd.setCursor(235, 220);
  M5.Lcd.printf("Move");
}
void rest() {
  M5.Lcd.clear(WHITE);
  for (int i = 0; i < 40; i++) {
    M5.update();
    display_rest();
    line_cursor(rest_size);
    if (M5.BtnA.wasReleased()) {
      for (int j = 0; j < rest_size; j++) {
          restaur[j].select_false();
      }
      restaur[cursor_row - 1].select();
    }
    if (M5.BtnB.wasReleased()) {
      save_rest();
      JSON_menu();
    }
    delay(10);
  }
}
void display_rest() {
  M5.Lcd.setCursor(80, 20);
  M5.Lcd.setTextSize(2);
  M5.Lcd.printf("Restaurants");
  M5.Lcd.drawFastHLine(0, 40, width , BLACK);
  for (int i = 0; i < rest_size; i++) {
    restaur[i].display_item();
  }
  draw_buttons();
  M5.Lcd.setTextSize(1);
  M5.Lcd.setCursor(140, 220);
  M5.Lcd.printf("Confirm");
  M5.Lcd.setCursor(45, 220);
  M5.Lcd.printf("Select");
  M5.Lcd.setCursor(235, 220);
  M5.Lcd.printf("Move");
}
void save_rest(){
  for(int i = 0; i < rest_size; i++){
    if(restaur[i].is_selected() == 1){
      rest_id = restaur[i].get_id();
      rest_name = restaur[i].get_name();
      Serial.println(rest_name);
    }
  }
}
void JSON_menu(){
  doc.clear();
  doc["queryID"] = 20;
  char name[40];
  JsonArray arr = doc.createNestedArray("restaurantSingle");
  JsonObject obj1 = arr.createNestedObject();
  rest_name.toCharArray(name, 40);
  obj1["resName"] = name;
  obj1["resID"] = rest_id;
  String output;
  serializeJson(doc, output);
  publishMessage(output);
}
void line_cursor(int size) {
  M5.Lcd.drawFastVLine(8, (cursor_row * 50), 15 , BLACK);
  if (M5.BtnC.wasReleased()) {
    if (cursor_row == size) {
      cursor_row = 1;
    }
    else {
      cursor_row++;
    }
  }
}
void menu() {
  M5.Lcd.clear(WHITE);
  for (int i = 0; i < 40; i++) {
    M5.update();
    display_menu();
    delay(20);
  }
}
void display_menu() {
  M5.Lcd.setCursor(120, 20);
  M5.Lcd.setTextSize(2);
  M5.Lcd.printf("Menu");
  M5.Lcd.drawFastHLine(0, 40, width , BLACK);
  M5.Lcd.setCursor(40, 50);
  M5.Lcd.setTextSize(1);
  M5.Lcd.printf("name");
  M5.Lcd.setCursor(120, 50);
  M5.Lcd.printf("calorie");
  M5.Lcd.setCursor(200, 50);
  M5.Lcd.printf("V");
  M5.Lcd.setCursor(240, 50);
  M5.Lcd.printf("GF");
  M5.Lcd.setCursor(280, 50);
  M5.Lcd.printf("N");
  draw_buttons();
  M5.Lcd.setCursor(140, 220);
  M5.Lcd.printf("Confirm");
  M5.Lcd.setCursor(45, 220);
  M5.Lcd.printf("Select");
  M5.Lcd.setCursor(235, 220);
  M5.Lcd.printf("Move");
}
void order() {
  M5.Lcd.clear(WHITE);
  for (int i = 0; i < 40; i++) {
    M5.update();
    M5.Lcd.setCursor(80, 20);
    M5.Lcd.setTextSize(2);
    M5.Lcd.printf("My order");
    M5.Lcd.drawFastHLine(0, 40, width , BLACK);
    M5.Lcd.setCursor(50, 50);
    M5.Lcd.setTextSize(1);
    M5.Lcd.printf("name");

  }
}
void draw_buttons() {
  M5.Lcd.drawRoundRect(40, 210, 50, 30, 5, BLUE);
  M5.Lcd.drawRoundRect(230, 210, 50, 30, 5, BLUE);
  M5.Lcd.drawRoundRect(135, 210, 50, 30, 5, BLUE);
}
void publishMessage(String message) { // edit this function

  if ( ps_client.connected()) {

    // Make sure the message isn't blank.
    if ( message.length() > 0 ) {

      // Convert to char array
      char msg[ message.length() ];
      message.toCharArray( msg, message.length() + 1 );


      // Send
      ps_client.publish( MQTT_pub_topic, msg );
    }

  } else {
    Serial.println("Can't publish message: Not connected to MQTT :( ");

  }
}
void callback(char* topic, byte* payload, unsigned int length) {

  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");

  // Copy chars to a String for convenience.
  // Also prints to USB serial for debugging
  for (int i = 0; i < length; i++) {
    JSON[i] = (char)payload[i];
    Serial.print((char)payload[i]);
  }
  Serial.println();
  DeserializationError err = deserializeJson(recieve, JSON);
  if (err) {
    Serial.print(F("deserializeJson() failed with code "));
    Serial.println(err.c_str());
  }
  queryID = recieve["queryID"];
  Serial.println(queryID);
}
void setupMQTT() {
  ps_client.setServer(server, port);
  ps_client.setCallback(callback);
}

void setupWifi() {

  byte mac[6];
  Serial.println("Original MAC address: " + String(WiFi.macAddress()));
  esp_base_mac_addr_set(guestMacAddress);
  Serial.println("Borrowed MAC address: " + String(WiFi.macAddress()));

  Serial.println("Connecting to network: " + String(ssid));
  WiFi.begin(ssid );
  while (WiFi.status() != WL_CONNECTED) delay(500);
  Serial.println("IP address allocated: " + String(WiFi.localIP()));
}
void reconnect() {
   M5.Lcd.clear(WHITE);
  // Loop until we're reconnected
  M5.Lcd.clear(WHITE);
  M5.Lcd.print("Connecting");
  while (!ps_client.connected()) {

    Serial.print("Attempting MQTT connection...");

    // Attempt to connect
    // Sometimes a connection with HiveMQ is refused
    // because an old Client ID is not erased.  So to
    // get around this, we just generate new ID's
    // every time we need to reconnect.
    String new_id = generateID();

    Serial.print("connecting with ID ");
    Serial.println( new_id );

    char id_array[ (int)new_id.length() ];
    new_id.toCharArray(id_array, sizeof( id_array ) );

    if (ps_client.connect( id_array ) ) {
      Serial.println("connected");

      // Once connected, publish an announcement...
      ps_client.publish( MQTT_pub_topic, "reconnected");
      // ... and resubscribe
      ps_client.subscribe( MQTT_sub_topic );
    } else {
      Serial.print("failed, rc=");
      Serial.print(ps_client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
  Serial.println(" - Success!  Connected to HiveMQ\n\n");
}

String generateID() {

  String id_str = MQTT_clientname;
  id_str += random(0, 9999);

  return id_str;
}
