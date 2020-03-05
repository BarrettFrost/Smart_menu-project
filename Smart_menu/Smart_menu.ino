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

int width;
int state;
int state_new = 0;
int state_set = 1;
int state_pref = 2;
int state_rest = 3;
int state_menu = 4;
int state_order = 5;
int calorie;
bool veg;
bool gluten;
bool allergy;
List diet[3];
List restaur[3];
String JSON;
int total_cal;
int cursor_row;

Preferences save;
const char* cal = "calorie";
const char* vegan = "veg";
const char* glut_f = "gluten";
const char* nut = "allergy";


uint8_t guestMacAddress[6] = {0xAC, 0xD5, 0x64, 0x6F, 0x65, 0xBB};
const char* ssid = "UoB Guest";                 // Set name of Wifi Network
const char* password = "";                      // No password for UoB Guest
// MQTT Settings
const char* MQTT_clientname = "Smart_menu"; // Make up a short name
const char* MQTT_sub_topic = "Smart_menu"; // pub/sub topics
const char* MQTT_pub_topic = "Smart_menu"; // You might want to create your own

// Please leave this alone - to connect to HiveMQ
const char* server = "broker.mqttdashboard.com";
const int port = 1883;

void setup() {
  M5.begin();
  M5.Power.begin();
  M5.Lcd.fillScreen(WHITE);
  Serial.begin(115200);
  delay(10);
  Serial.println("*** RESET ***\n");
  state = state_new;
  diet[0].intial(1, "vegan(V)");
  diet[1].intial(2, "gluten free(GF)");
  diet[2].intial(3, "contains nuts(N)");
  restaur[0].intial(1, "restaurant 1");
  restaur[1].intial(2, "restaurant 2");
  restaur[2].intial(3, "restaurant 3");
  save.begin("data");
  calorie = save.getUInt(cal);
  veg = save.getBool(vegan);
  gluten = save.getUInt(glut_f);
  allergy = save.getUInt(nut);
  width = 320;
  cursor_row = 1;
  /*setupWifi();
  setupMQTT();*/
}

void loop() {

  /*if (!ps_client.connected()) {
    reconnect();
  }
  ps_client.loop();*/

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
    if (M5.BtnA.wasReleased()) {
      state = state_set;
    }
    if (M5.BtnB.wasReleased()) {
      state = state_rest;
    }
    delay (5);
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
      save.putUInt(cal, calorie);
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
      save.putBool(vegan, diet[0].is_selected());
      save.putBool(glut_f, diet[1].is_selected());
      save.putBool(nut, diet[2].is_selected());
    }
    line_cursor();
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
    line_cursor();
    if (M5.BtnA.wasReleased()) {
      if (cursor_row == 1) {
        restaur[0].select();
        if (restaur[2].is_selected()) {
          restaur[2].select();
        }
        if (restaur[1].is_selected()) {
          restaur[1].select();
        }
      }
      else if (cursor_row == 2) {
        restaur[1].select();
        if (restaur[0].is_selected()) {
          restaur[0].select();
        }
        if (restaur[2].is_selected()) {
          restaur[2].select();
        }
      }
      else {
        restaur[2].select();
        if (restaur[0].is_selected()) {
          restaur[0].select();
        }
        if (restaur[1].is_selected()) {
          restaur[1].select();
        }
      }
    }
    if (M5.BtnB.wasReleased()) {
      state = state_menu;
      //wifi stuff
    }
    delay(20);
  }
}
void display_rest() {
  M5.Lcd.setCursor(80, 20);
  M5.Lcd.setTextSize(2);
  M5.Lcd.printf("Restaurants");
  M5.Lcd.drawFastHLine(0, 40, width , BLACK);
  restaur[0].display_item();
  restaur[1].display_item();
  restaur[2].display_item();
  draw_buttons();
  M5.Lcd.setTextSize(1);
  M5.Lcd.setCursor(140, 220);
  M5.Lcd.printf("Confirm");
  M5.Lcd.setCursor(45, 220);
  M5.Lcd.printf("Select");
  M5.Lcd.setCursor(235, 220);
  M5.Lcd.printf("Move");
}
void line_cursor() {
  M5.Lcd.drawFastVLine(8, (cursor_row * 50), 15 , BLACK);
  if (M5.BtnC.wasReleased()) {
    if (cursor_row == 3) {
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
void publishMessage( String message ) { // edit this function

  if ( ps_client.connected() ) {

    // Make sure the message isn't blank.
    if ( message.length() > 0 ) {

      // Convert to char array
      char msg[ message.length() ];
      message.toCharArray( msg, message.length() );

      M5.Lcd.print(">> Tx: ");
      M5.Lcd.println( message );

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

  String in_str = "";

  // Copy chars to a String for convenience.
  // Also prints to USB serial for debugging
  for (int i = 0; i < length; i++) {
    in_str += (char)payload[i];
    Serial.print((char)payload[i]);
  }
  Serial.println();
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

  // Loop until we're reconnected
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
