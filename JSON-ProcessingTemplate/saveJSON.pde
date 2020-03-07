void saveJSON(JSONPacket p){
 JSONObject packet = new JSONObject();
 
 //QueryID
 packet.setInt("queryID", p.getID());

 //RestaurantList
 JSONArray resArr = new JSONArray();
 for(int i=0;i<p.getListSize();i++){
  JSONObject obj = new JSONObject();
  Restaurant res = p.getList().get(i);
  
  //RestaurantID
  obj.setString("resID", res.getID());
  //RestaurantName
  obj.setString("resName", res.getName());
  
  //Menu
  JSONArray menuArr = new JSONArray();
  for(int j=0;j<res.getMenuSize();j++){
    JSONObject obj2 = new JSONObject();
    Food f = res.getMenu().get(j);
    
    //FoodName
    obj2.setString("foodName", f.getName());
    //Calories
    obj2.setInt("calories", f.getCal());
    //Vegan
    obj2.setBoolean("vegan", f.getVegan());
    //ContainsGluten
    obj2.setBoolean("containsGluten", f.getContainsGluten());
    //ContainsNuts
    obj2.setBoolean("containsNuts", f.getContainsNuts());
    
    //Save Food to Menu 
    menuArr.setJSONObject(j, obj2);
  }  
  //Save Menu to Restaurant
  obj.setJSONArray("menu", menuArr);
  //MenuSize
  obj.setInt("menuSize", res.getMenuSize());
  
  //Save Restaurant to RestaurantList
  resArr.setJSONObject(i, obj);
 }
 //save RestaurantList to Packet
 packet.setJSONArray("resList", resArr);
 //ListSize
 packet.setInt("listSize", p.getListSize());
 
 //RestaurantSingle
 JSONObject obj = new JSONObject();
 Restaurant res = p.getResSingle();
 
 //RestaurantID
 obj.setString("resID", res.getID());
 //RestaurantName
 obj.setString("resName", res.getName());
 
 //Menu
 JSONArray menuArr = new JSONArray();
 for(int i=0;i<res.getMenuSize();i++){
   JSONObject obj2 = new JSONObject();
   Food f = res.getMenu().get(i);
   
   //FoodName
   obj2.setString("foodName", f.getName());
   //Calories
   obj2.setInt("calories", f.getCal());
   //Vegan
   obj2.setBoolean("vegan", f.getVegan());
   //ContainsGluten
   obj2.setBoolean("containsGluten", f.getContainsGluten());
   //ContainsNuts
   obj2.setBoolean("containsNuts", f.getContainsNuts());
    
   //Save Food to Menu
   menuArr.setJSONObject(i, obj2);
 }  
 //Save Menu to Restaurant
 obj.setJSONArray("menu", menuArr);
 //MenuSize
 obj.setInt("menuSize", res.getMenuSize());
 
 //Save Restaurant
 packet.setJSONObject("restaurantSingle", obj); 

 saveJSONObject(packet, "JSONPacket.json");
}
