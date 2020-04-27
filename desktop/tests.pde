// to do:
// Check if null is returned before performing operations on the new JSONObject in case the String content could not be parsed.
// Make sure the API is returning values correctly.



void run_tests() {
  println("------------------test start-------------------");
  //test restaurant
  Restaurant res = new Restaurant("name", "id");
  assert(res.name.equals("name"));
  assert(res.id.equals("id"));
  assert(res.toString().equals("name(ID:id)"));
  
  //test food
  Food f = new Food("name", 3, true, true, true);
  assert(f.name.equals("name"));
  assert(f.calories == 3);
  assert(f.vegetarian);
  assert(f.gluten);
  assert(f.nuts);
  
  Food f2 = new Food("name2", 1, false, false,false);
  assert(f2.name.equals("name2"));
  assert(f2.calories == 1);
  assert(!f2.vegetarian);
  assert(!f2.gluten);
  assert(!f2.nuts);
  
  //test menu
  Menu m = new Menu();
  assert(m.size() == 0);
  m.addFood(f);
  assert(m.size() == 1);
  assert(m.get(0).name.equals("name"));
  assert(m.get(0).calories == 3);
  assert(m.get(0).vegetarian);
  assert(m.get(0).gluten);
  assert(m.get(0).nuts);
  m.set(0, f2);
  assert(m.size() == 1);
  assert(m.get(0).name.equals("name2"));
  assert(m.get(0).calories == 1);
  assert(!m.get(0).vegetarian);
  assert(!m.get(0).gluten);
  assert(!m.get(0).nuts);
  m.remove(0);
  assert(m.size() == 0);
  
  //test json1
  JSONObject empty = parseJSONObject("{\"conID\": 56}");
  assert(empty != null);
  assert(empty.getString("a") == null);
  
  //test json2
  String payload = "{\"conID\": 56,   \"queryID\": 40,   \"resList\": [],   \"listSize\": 0,   \"restaurantSingle\": {     \"resID\": \"ek0l\",     \"resName\": \"Nandos\",     \"menu\": [{       \"foodName\": \"Quarter Chicken\",       \"calories\": 600,       \"vegan\": false,       \"containsNuts\": true,       \"containsGluten\": false,       \"setContainsNuts\": true     }, {       \"foodName\": \"Peri Burger\",       \"calories\": 750,       \"vegan\": false,       \"containsNuts\": true,       \"containsGluten\": false,       \"setContainsNuts\": true     }, {       \"foodName\": \"Salad\",       \"calories\": 300,       \"vegan\": true,       \"containsNuts\": true,       \"containsGluten\": true,       \"setContainsNuts\": true     }],     \"menuSize\": 3   } }";
  JSONObject json = parseJSONObject(payload);
  assert(json != null);
  assert(json.getInt("conID") == 56);
  assert(json.getInt("listSize") == 0);
  assert(json.getJSONArray("resList").size() == 0);
  
  JSONObject single = json.getJSONObject("restaurantSingle");
  assert(single.getString("resID").equals("ek0l"));
  assert(single.getString("resName").equals("Nandos"));
  assert(single.getInt("menuSize") == 3);
  
  JSONArray ma = single.getJSONArray("menu");
  m = new Menu(ma);
  assert(m.size() == 3);
  assert(m.get(0).name.equals("Quarter Chicken"));
  assert(m.get(0).calories == 600);
  assert(!m.get(0).vegetarian);
  assert(!m.get(0).gluten);
  assert(m.get(0).nuts);
  assert(m.get(1).name.equals("Peri Burger"));
  assert(m.get(1).calories == 750);
  assert(!m.get(1).vegetarian);
  assert(!m.get(1).gluten);
  assert(m.get(1).nuts);
  
  println("all tests passed");
  println("------------------test finish-------------------");
}
