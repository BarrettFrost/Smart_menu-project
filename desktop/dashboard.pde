import mqtt.*;
import controlP5.*;

ControlP5 cp5;
MQTTClient client;
View view;
Menu menu;
ViewType currentView;

void setup() {
  run_tests();

  cp5 = new ControlP5(this);

  size(900, 700);

  menu = loadMenu();

  view = new View();

  // connect to the broker
  client = new MQTTClient(this);
  // connect to the broker and use a random string for clientid
  client.connect("mqtt://try:try@broker.hivemq.com", "processing_desktop" + str(random(3)));
  delay(100);

  // refresh the dashboard with the information
  view.update();
}

// we don't really use the draw function as controlP5 does the work
void draw() {
  background(0);

  if (currentView != null) {
    view.toView(currentView);
    view.update();
    currentView = null;
  }
}
