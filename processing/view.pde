

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
  final PFont fontList = createFont("Times", 19);

  final float topx = 50;
  final float topy = 60;

  ViewType type;

  Textlabel status;

  //register
  Textfield tfResturantName;
  Button btnCancel;
  Button btnRegister;

  //main view
  Textlabel lblRestaurant;
  Button btnAdd, btnEdit, btnDelete;
  ScrollableList list;
  int selectedIndex = -1;

  //add view
  Textfield tfName;
  Textfield tfPrice;
  Textfield tfCalories;
  Toggle tgvegetarian;
  Button btnAddItem;

  View() {
    cp5.addGroup("all");
    
    if (hasLocalRestaurant()) {
      toView(ViewType.OrderList);
    } else {
      toView(ViewType.Register);
    }
  }

  void toView(ViewType type) {
    this.type = type;
    
    cp5.remove("all");
    cp5.addGroup("all");

    if (type == ViewType.Register) {
      buildRegisterView();
    } else if (type == ViewType.OrderList) {
      buildMainView();
    } else if (type == ViewType.Add) {
      buildAddView();
    }
  }

  void buildAddView() {
    float x = topx;
    float y = topy;

    Textlabel lblAdd = cp5.addTextlabel("addTitle");
    lblAdd.setText("Add");
    lblAdd.setPosition(x, y);
    lblAdd.setSize(300, 50);
    lblAdd.setFont(fontTitle);
    lblAdd.setGroup("all");

    x = topx;
    y += 80;
    Textlabel lblName = cp5.addTextlabel("nameLabel");
    lblName.setText("Name: ");
    lblName.setPosition(x, y);
    lblName.setSize(250, 30);
    lblName.setFont(fontLabel);
    lblName.setGroup("all");

    x += 300;
    tfName = cp5.addTextfield(" ");
    tfName.setPosition(x, y);
    tfName.setSize(200, 35);
    tfName.setFont(fontLabel);
    tfName.setGroup("all");

    x = topx;
    y += 80;
    Textlabel lblPrice = cp5.addTextlabel("priceLabel");
    lblPrice.setText("Price: ");
    lblPrice.setPosition(x, y);
    lblPrice.setSize(250, 30);
    lblPrice.setFont(fontLabel);
    lblPrice.setGroup("all");

    x += 300;
    tfPrice = cp5.addTextfield("  ");
    tfPrice.setPosition(x, y);
    tfPrice.setSize(200, 35);
    tfPrice.setFont(fontLabel);
    tfPrice.setGroup("all");
    
    x = topx;
    y += 150;
    btnAddItem = cp5.addButton("Add Item");
    btnAddItem.setFont(fontButton);
    btnAddItem.setSize(220, 30);
    btnAddItem.setPosition(x, y);
    btnAddItem.setGroup("all");

    x += 260;
    btnCancel = cp5.addButton("cancel");
    btnCancel.setFont(fontButton);
    btnCancel.setSize(220, 30);
    btnCancel.setPosition(x, y);
    btnCancel.setGroup("all");

    x = topx;
    y += 50;
    status = cp5.addTextlabel("status");
    status.setColor(color(255, 0, 0));
    status.setText("");
    status.setPosition(x, y);
    status.setSize(250, 30);
    status.setFont(fontLabel);
    status.setGroup("all");
  }

  void buildMainView() {
    selectedIndex = -1;


    float x = topx;
    float y = topy - 30;

    lblRestaurant = cp5.addTextlabel("restaurantName");
    lblRestaurant.setPosition(x, y);
    lblRestaurant.setSize(200, 50);
    lblRestaurant.setFont(fontTitle);
    lblRestaurant.setGroup("all");

    y += 70;
    Textlabel lblMenu = cp5.addTextlabel("menuTitle");
    lblMenu.setText("Menu");
    lblMenu.setPosition(x, y);
    lblMenu.setSize(200, 50);
    lblMenu.setFont(fontTitle);
    lblMenu.setGroup("all");

    x += 200;
    btnAdd = cp5.addButton("add");
    btnAdd.setFont(fontTitle);
    btnAdd.setSize(150, 40);
    btnAdd.setPosition(x, y);
    btnAdd.setGroup("all");

    x += 180;
    btnEdit = cp5.addButton("edit");
    btnEdit.setFont(fontTitle);
    btnEdit.setSize(150, 40);
    btnEdit.setPosition(x, y);
    btnEdit.setGroup("all");

    x += 180;
    btnDelete = cp5.addButton("delete");
    btnDelete.setFont(fontTitle);
    btnDelete.setSize(200, 40);
    btnDelete.setPosition(x, y);
    btnDelete.setGroup("all");

    x = topx;
    y += 100;
    list = cp5.addScrollableList("list");
    list.setSize((int)(900 - 2 * topx), 350);
    list.setBarVisible(false);
    list.setPosition(x, y);
    list.setType(ControlP5.LIST);
    list.setItemHeight(50);
    list.setFont(fontList);
    list.setGroup("all");

    y += 420;
    status = cp5.addTextlabel("status");
    status.setColor(color(255, 0, 0));
    status.setText("");
    status.setPosition(x, y);
    status.setSize(250, 30);
    status.setFont(fontButton);
    status.setGroup("all");
  }

  void buildRegisterView() {
    float x = topx;
    float y = topy;

    Textlabel lblRegistration = cp5.addTextlabel("registrationTitle");
    lblRegistration.setText("Register Restaurant");
    lblRegistration.setPosition(x, y);
    lblRegistration.setSize(300, 50);
    lblRegistration.setFont(fontTitle);
    lblRegistration.setGroup("all");

    y += 200;
    Textlabel lblRestaurantName = cp5.addTextlabel("restaurantNameLabel");
    lblRestaurantName.setText("Restaurant Name: ");
    lblRestaurantName.setPosition(x, y);
    lblRestaurantName.setSize(250, 30);
    lblRestaurantName.setFont(fontLabel);
    lblRestaurantName.setGroup("all");

    x += 300;
    tfResturantName = cp5.addTextfield(" ");
    tfResturantName.setPosition(x, y);
    tfResturantName.setSize(200, 35);
    tfResturantName.setFont(fontLabel);
    tfResturantName.setGroup("all");

    x = topx;
    y += 150;
    btnRegister = cp5.addButton("registration");
    btnRegister.setFont(fontButton);
    btnRegister.setSize(220, 30);
    btnRegister.setPosition(x, y);
    btnRegister.setGroup("all");


    x += 260;
    btnCancel = cp5.addButton("cancel");
    btnCancel.setFont(fontButton);
    btnCancel.setSize(220, 30);
    btnCancel.setPosition(x, y);
    btnCancel.setGroup("all");

    x = topx;
    y += 50;
    status = cp5.addTextlabel("status");
    status.setColor(color(255, 0, 0));
    status.setText("");
    status.setPosition(x, y);
    status.setSize(250, 30);
    status.setFont(fontLabel);
    status.setGroup("all");
  }

  void update() {
    if (type == ViewType.Register) {
    } else if (type == ViewType.OrderList) {
      Restaurant res = loadRestaurant();

      lblRestaurant.setText(res.toString());

      list.clear();
      selectedIndex = -1;
      for (int i=0; i<menu.size(); i++) {
        list.addItem(menu.get(i).toString(), menu.get(i).toString());
      }
    }
  }
}
