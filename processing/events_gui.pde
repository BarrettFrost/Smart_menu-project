
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
  }else if (view.type == ViewType.Add) {
      //view.toView(ViewType.OrderList);
      currentView = ViewType.OrderList;
  }
}

public void list(int n){
  view.selectedIndex = n;
}

public void delete() {
  view.status.setText("");
  if(view.selectedIndex == -1){
     view.status.setText("You haven't select an item"); 
  }else{
    doDelete(view.selectedIndex);
  }
}

public void add() {
  //view.toView(ViewType.Add);
  currentView = ViewType.Add;
}
