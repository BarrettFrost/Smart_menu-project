
//call back of buttons

public void registration() {
  String input = view.tfResturantName.getText().trim();
  view.status.setText("");
  
  if(input.isEmpty()){
    view.status.setText("Your input is empty.");
  }else{
    doRegister(input, menu);
  }
}

public void cancel() {
    println("cancel");
    
  if(hasLocalRestaurant()){
    view.toView(ViewType.OrderList);
  }else{
    System.exit(0);
  }

}
