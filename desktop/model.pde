
class Restaurant {
  String name;
  String id;

  Restaurant(String name, String id) {
    this.name = name;
    this.id = id;
  }

  String toString(){
     return name + "(ID:" + id + ")"; 
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
  boolean gluten;
  boolean nuts;

  Food(String name, int calories,  boolean vegetarian, boolean gluten, boolean nuts) {
    this.name = name;
    this.calories = calories;
    this.vegetarian = vegetarian;
    this.gluten = gluten;
    this.nuts = nuts;
  }
  
  String toString(){
    return String.format("%s, Calories: %d, vegetarian: %s, *containsGluten: %s, containsNuts: %s", name, calories, 
      vegetarian?"Y":"N", gluten?"Y":"N", nuts?"Y":"N");
  }
  
  Food(JSONObject jb) {
    name = jb.getString("foodName");
    calories = jb.getInt("calories");
    vegetarian = jb.getBoolean("vegan");
    gluten = jb.getBoolean("containsGluten");
    nuts = jb.getBoolean("containsNuts");
  }

  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.put("foodName", name);
    json.put("calories", calories);
    json.put("vegan", vegetarian);
    json.put("containsGluten", gluten);
    json.put("containsNuts", nuts);
    return json;
  }
}

class Menu {
  Food[] foods;

  Menu() {
    foods = new Food[0];
    
    //addFood(new Food("Food1", 30, true, false ,true));
    //addFood(new Food("Food2", 30, false, false ,false));
    //addFood(new Food("Food3", 20, false, true ,true));
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

  void remove(int index){
      for(int i=index;i<foods.length-1;i++){
         foods[index] = foods[i+1]; 
      }
      foods = (Food[])shorten(foods);
  }
  
  Food get(int index){
    return foods[index];
  }
  
  void set(int index, Food f){
     foods[index] = f; 
  }
  
  int size(){
    return foods.length;
  }
  
  JSONArray toJson() {
    JSONArray array = new JSONArray();
    for (Food f : foods) {
      array.append(f.toJson());
    }
    return array;
  }
}
