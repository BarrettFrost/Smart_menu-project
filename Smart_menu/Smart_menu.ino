#include <M5Stack.h>
#include <WiFi.h>
#include <esp_wifi.h>
WiFiClient wifi_client;
#include "Timer.h"

int state;
int state_new = 0;
int state_set = 1;
int state_end = 6;
int cal;

void setup() {
  M5.begin();
  M5.Power.begin();
  M5.Lcd.fillScreen(WHITE);
  Serial.begin(115200);
  delay(10);
  Serial.println("*** RESET ***\n");
  state = state_new;
  
}

void loop() {
  switch(state){
  case 0 :
    newmeal();
    break;
  case 1:
    set_cal();
    break;
  case 6:
    end();
    break;  
  default :
  M5.Lcd.printf("Unknown state");
  break;
  }
}

void newmeal(){
  int i;
  for(i =0; i < 10; i++){
  M5.update();
  M5.Lcd.setCursor(50, 75);
  M5.Lcd.setTextColor(BLACK);
  M5.Lcd.setTextSize(5);
  M5.Lcd.printf("New meal");
  M5.Lcd.drawRoundRect(135, 210, 50, 30, 5, BLUE);
  M5.Lcd.fillRoundRect(135, 210, 50, 30, 5, BLUE);
  if (M5.BtnB.wasReleased()) {
    state = state_set;
  }
  delay (5);
  }
}
void set_cal(){
  M5.Lcd.clear(WHITE);
  int i;
  for(i =0; i < 40; i++){
    M5.update();
    M5.Lcd.setCursor(20, 75);
    M5.Lcd.setTextSize(3);
    M5.Lcd.printf("Set MAX Calories");
    M5.Lcd.drawNumber(cal, 130, 150);
    M5.Lcd.drawRoundRect(40, 210, 50, 30, 5, BLUE);
    M5.Lcd.drawRoundRect(230, 210, 50, 30, 5, BLUE);
    M5.Lcd.drawRoundRect(135, 210, 50, 30, 5, BLUE);
    M5.Lcd.drawFastHLine(55, 225, 20, BLACK);
    M5.Lcd.drawFastHLine(245, 225, 20, BLACK);
    M5.Lcd.drawFastVLine(255, 215, 20, BLACK);
    M5.Lcd.setCursor(140, 220);
    M5.Lcd.setTextSize(1);
    M5.Lcd.printf("Confirm");
    if (M5.BtnA.wasReleased()) {
      if(cal != 0){
      cal = cal - 50;
      }
    }
    if (M5.BtnC.wasReleased()) {
      cal = cal + 50;
    }
    if (M5.BtnB.wasReleased()) {
      state = state_end;
    }
    delay (20);
  }
}
  void end(){
  M5.Lcd.clear(WHITE);
  int i;
  for(i =0; i < 40; i++){
     M5.update();
     M5.Lcd.setCursor(50, 75);
     M5.Lcd.setTextColor(BLACK);
     M5.Lcd.setTextSize(3);
     M5.Lcd.printf("Finished meal");
     M5.Lcd.drawRoundRect(135, 210, 50, 30, 5, BLUE);
     M5.Lcd.fillRoundRect(135, 210, 50, 30, 5, BLUE);
     if (M5.BtnB.wasReleased()) {
    
     }
     delay (20);
   }
  }
  
