

enum ViewType {
  Register, 
    Add, 
    OrderList
}

class View {
  final PFont fontTitle = createFont("Times", 35);
  final PFont fontMenu = createFont("Times", 32);
  final PFont fontLabel = createFont("Times", 28);
  final PFont fontButton = createFont("Times", 23);

  final float topx = 50;
  final float topy = 60;

  ViewType type;

  Textlabel status;

  //register
  Textfield tfResturantName;
  Button btnCancel;
  Button btnRegister;

  View() {
    if (hasLocalRestaurant()) {
      type = ViewType.OrderList;
      buildMainView();
    } else {
      type = ViewType.Register;
      buildRegisterView();
    }
  }

  void toView(ViewType type) {
    if (type == ViewType.Register) {
      type = ViewType.Register;
      buildRegisterView();
    } else if (type == ViewType.OrderList) {
      type = ViewType.OrderList;
      buildMainView();
    }
  }

  void buildMainView() {
    
  }

  void buildRegisterView() {
    float x = topx;
    float y = topy;

    Textlabel lblRegistration = cp5.addTextlabel("registrationTitle");
    lblRegistration.setText("Register Restaurant");
    lblRegistration.setPosition(x, y);
    lblRegistration.setSize(300, 50);
    lblRegistration.setFont(fontTitle);

    y += 200;
    Textlabel lblRestaurantName = cp5.addTextlabel("restaurantNameLabel");
    lblRestaurantName.setText("Restaurant Name: ");
    lblRestaurantName.setPosition(x, y);
    lblRestaurantName.setSize(250, 30);
    lblRestaurantName.setFont(fontLabel);

    x += 300;
    tfResturantName = cp5.addTextfield("");
    tfResturantName.setPosition(x, y);
    tfResturantName.setSize(200, 30);
    tfResturantName.setFont(fontLabel);

    x = topx;
    y += 150;
    btnRegister = cp5.addButton("registration");
    btnRegister.setFont(fontButton);
    btnRegister.setSize(220, 30);
    btnRegister.setPosition(x, y);

    x += 260;
    btnCancel = cp5.addButton("cancel");
    btnCancel.setFont(fontButton);
    btnCancel.setSize(220, 30);
    btnCancel.setPosition(x, y);

    x = topx;
    y += 50;
    status = cp5.addTextlabel("status");
    status.setColor(color(255, 0, 0));
    status.setText("");
    status.setPosition(x, y);
    status.setSize(250, 30);
    status.setFont(fontLabel);
  }

  void update() {
    menu = loadMenu();
    
    if (type == ViewType.Register) {
    } else if (type == ViewType.OrderList) {
    }
  }
}
