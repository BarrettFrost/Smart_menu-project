
class Restaurant {
  String name;
  String id;

  Restaurant(String name, String id) {
    this.name = name;
    this.id = id;
  }

  Restaurant(JSONObject jb) {
    name = jb.getString("name");
    id = jb.getString("id");
  }
  
   JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.put("name", name);
    json.put("id", id);
    return json;
  }
}

class Food {
  String name;
  int calories;
  boolean vegetarian;
  boolean glutenFree;
  boolean nuts;

  Food(String name, int calories,  boolean vegetarian, boolean glutenFree, boolean nuts) {
    this.name = name;
    this.calories = calories;
    this.vegetarian = vegetarian;
    this.glutenFree = glutenFree;
    this.nuts = nuts;
  }
  
  Food(JSONObject jb) {
    name = jb.getString("name");
    calories = jb.getInt("calories");
    vegetarian = jb.getBoolean("vegetarian");
    glutenFree = jb.getBoolean("glutenFree");
    nuts = jb.getBoolean("nuts");
  }

  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.put("name", name);
    json.put("calories", calories);
    json.put("vegetarian", vegetarian);
    json.put("glutenFree", glutenFree);
    json.put("nuts", nuts);
    return json;
  }
}

class Menu {
  Food[] foods;

  Menu() {
    foods = new Food[0];
  }

  Menu(JSONArray jb) {
    foods = new Food[jb.size()];
    for(int i=0;i<foods.length;i++){
      foods[i] = new Food(jb.getJSONObject(i));
    }
  }
  
  void addFood(Food food) {
    foods = (Food[])append(foods, food);
  }

  JSONArray toJson() {
    JSONArray array = new JSONArray();
    for (Food f : foods) {
      array.append(f.toJson());
    }
    return array;
  }
}
