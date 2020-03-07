void JSONtest(){
  Food f = new Food();
  f.setName("Fried Chicken");
  f.setCal(600);
  f.setVegan(false);
  f.setContainsGluten(true);
  f.setContainsNuts(true);
  
  Restaurant res = new Restaurant();
  res.setName("KFC");
  res.setID("AA32");
  res.addToMenu(f);
 
  JSONPacket packet = new JSONPacket();
  packet.setID(10);
  packet.addToList(res);
  packet.setResSingle(res);
  
  //test packet functions
  packet.debugPrint();
  //test JSON saving
  saveJSON(packet);
  //test JSON loading
  packet = loadJSON();
  //print again to ensure JSON loaded properly
  packet.debugPrint();
}
