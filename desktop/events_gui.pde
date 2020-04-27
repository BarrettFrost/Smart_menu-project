
//call back of buttons

public void registration() {
  String input = view.tfResturantName.getText().trim();
  view.status.setText("");

  if (input.isEmpty()) {
    view.status.setText("Your input is empty.");
  } else {
    doRegister(input, menu);
  }
}

public void cancel() {
  println("cancel");
  if (view.type == ViewType.Register) {
    if (hasLocalRestaurant()) {
      //view.toView(ViewType.OrderList);
      currentView = ViewType.OrderList;
    } else {
      System.exit(0);
    }
  } else if (view.type == ViewType.Add || view.type == ViewType.Edit) {
    //view.toView(ViewType.OrderList);
    currentView = ViewType.OrderList;
  }
}

public void list(int n) {
  view.selectedIndex = n;
}

public void delete() {
  view.status.setText("");
  if (view.selectedIndex == -1) {
    view.status.setText("You haven't select an item");
  } else {
    doDelete(view.selectedIndex);
  }
}

public void edit() {
  view.status.setText("");
  if (view.selectedIndex == -1) {
    view.status.setText("You haven't select an item");
  } else {
    currentView = ViewType.Edit;
  }
}

public void add() {
  //view.toView(ViewType.Add);
  currentView = ViewType.Add;
}

public void new_res(){
  currentView = ViewType.Register;
}

public void add_item() {
  println("add item"); 
  view.status.setText("");
  try {
    String name = view.tfName.getText();
    if (name.isEmpty()) {
      view.status.setText("please fill in the food name");
      return;
    }

    int calories = Integer.parseInt(view.tfCalories.getText());
    boolean v = view.tglVegetarian.getBooleanValue();
    boolean g = view.tglGlutenFree.getBooleanValue();
    boolean nuts = view.tglNuts.getBooleanValue();

    Food f = new Food(name, calories, v, g, nuts);

    doAdd(f);
  }
  catch(Exception e) {
    view.status.setText("please fill the text fields with correct value");
  }
}

public void edit_item() {
  println("edit item"); 
  view.status.setText("");
  try {
    String name = view.tfName.getText();
    if (name.isEmpty()) {
      view.status.setText("please fill in the food name");
      return;
    }

    int calories = Integer.parseInt(view.tfCalories.getText());
    boolean v = view.tglVegetarian.getBooleanValue();
    boolean g = view.tglGlutenFree.getBooleanValue();
    boolean nuts = view.tglNuts.getBooleanValue();

    Food f = new Food(name, calories, v, g, nuts);

    doUpdate(view.selectedIndex, f);
  }
  catch(Exception e) {
    view.status.setText("please fill the text fields with correct value");
  }
}
