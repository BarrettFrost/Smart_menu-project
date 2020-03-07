JSONPacket loadJSON(){
 JSONObject objPacket = loadJSONObject("JSONPacket.json");
 JSONPacket packet = new JSONPacket();
 
 //QueryID
 packet.setID(objPacket.getInt("queryID"));
 
 //RestaurantList
 JSONArray resArr = objPacket.getJSONArray("resList");
 for(int i=0;i<resArr.size();i++){
  JSONObject objRes = resArr.getJSONObject(i);
  Restaurant res = new Restaurant();
  
  //RestaurantID
  res.setID(objRes.getString("resID"));
  //RestaurantName
  res.setName(objRes.getString("resName"));
  
  //Menu
  JSONArray menuArr = objRes.getJSONArray("menu");
  for(int j=0;j<menuArr.size();j++){
   JSONObject objFood = menuArr.getJSONObject(j);
   Food f = new Food();
   
   //FoodName
   f.setName(objFood.getString("foodName"));
   //Calories
   f.setCal(objFood.getInt("calories"));
   //Vegan
   f.setVegan(objFood.getBoolean("vegan"));
   //Gluten
   f.setContainsGluten(objFood.getBoolean("containsGluten"));
   //Nuts
   f.setContainsNuts(objFood.getBoolean("containsNuts"));
   
   //Add to Menu
   res.addToMenu(f);
  }
  //Add to List
  packet.addToList(res);  
 }
 
 //RestaurantSingle
 JSONObject objRes = objPacket.getJSONObject("restaurantSingle");
 Restaurant res = new Restaurant();

 //RestaurantID
 res.setID(objRes.getString("resID"));
 //RestaurantName
 res.setName(objRes.getString("resName"));

 //Menu
 JSONArray menuArr = objRes.getJSONArray("menu");
 for(int i=0;i<menuArr.size();i++){
  JSONObject objFood = menuArr.getJSONObject(i);
  Food f = new Food();
 
  //FoodName
  f.setName(objFood.getString("foodName"));
  //Calories
  f.setCal(objFood.getInt("calories"));
  //Vegan
  f.setVegan(objFood.getBoolean("vegan"));
  //Gluten
  f.setContainsGluten(objFood.getBoolean("containsGluten"));
  //Nuts
  f.setContainsNuts(objFood.getBoolean("containsNuts"));
 
  //Add to Menu
  res.addToMenu(f);
 }
 //Add to restaurant Single
 packet.setResSingle(res);
 
 return packet;
}
