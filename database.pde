
String pathRestaurant = "data/restaurant.json";
String pathMenu = "data/menu.json";

boolean hasLocalRestaurant() {
  try {
    JSONObject json = loadJSONObject(pathRestaurant);
    return json != null;
  }
  catch(Exception e) {
    return false;
  }
}

Restaurant loadRestaurant() {
  JSONObject json = loadJSONObject(pathRestaurant);
  return new Restaurant(json);
}

Menu loadMenu() {
  try {
    JSONArray json = loadJSONArray(pathMenu);
    if (json == null) {
      return new Menu();
    } else {
      return new Menu(json);
    }
  }
  catch(Exception e) {
    return new Menu();
  }
}
