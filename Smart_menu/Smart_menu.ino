#include <M5Stack.h>
#include <WiFi.h>
#include <esp_wifi.h>
WiFiClient wifi_client;
#include "Timer.h"
#include "List.h"
#include "Arduino.h"
#include <Preferences.h>

int width;
int state;
int state_new = 0;
int state_set = 1;
int state_pref = 2;
int state_rest = 3;
int calorie;
bool veg;
bool gluten;
bool allergy;
List diet[3];
List restaur[3];
Preferences save;
const char* cal = "calorie";
const char* vegan = "veg";
const char* glut_f = "gluten";
const char* nut = "allergy";
int cursor_row;

void setup() {
  M5.begin();
  M5.Power.begin();
  M5.Lcd.fillScreen(WHITE);
  Serial.begin(115200);
  delay(10);
  Serial.println("*** RESET ***\n");
  state = state_new;
  diet[0].intial(1, "vegan");
  diet[1].intial(2, "gluten free");
  diet[2].intial(3, "nut allergy");
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
}

void loop() {
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
    default :
      M5.Lcd.printf("Unknown state");
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
    if (M5.BtnC.wasReleased()) {
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
        if(restaur[2].is_selected()){restaur[2].select();}
        if(restaur[1].is_selected()){restaur[1].select();}
      }
      else if (cursor_row == 2) {
        restaur[1].select();
        if(restaur[0].is_selected()){restaur[0].select();}
        if(restaur[2].is_selected()){restaur[2].select();}
      }
      else {
        restaur[2].select();
        if(restaur[0].is_selected()){restaur[0].select();}
        if(restaur[1].is_selected()){restaur[1].select();}
      }
    }
    delay(20);
  }
}
void display_rest(){
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
void draw_buttons() {
  M5.Lcd.drawRoundRect(40, 210, 50, 30, 5, BLUE);
  M5.Lcd.drawRoundRect(230, 210, 50, 30, 5, BLUE);
  M5.Lcd.drawRoundRect(135, 210, 50, 30, 5, BLUE);
}
