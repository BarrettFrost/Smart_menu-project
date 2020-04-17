
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
  int price;
  int calories;
  boolean vegetarian;
  boolean glutenFree;
  boolean nuts;

  Food(String name, int price, int calories,  boolean vegetarian, boolean glutenFree, boolean nuts) {
    this.name = name;
    this.price = price;
    this.calories = calories;
    this.vegetarian = vegetarian;
    this.glutenFree = glutenFree;
    this.nuts = nuts;
  }
  
  String toString(){
    return String.format("%s, price: $%d, Calories: %d, vegetarian: %s, *Gluten-free: %s, Nuts: %s", name, price, calories, 
      vegetarian?"Y":"N", glutenFree?"Y":"N", nuts?"Y":"N");
  }
  
  Food(JSONObject jb) {
    name = jb.getString("name");
    price = jb.getInt("price");
    calories = jb.getInt("calories");
    vegetarian = jb.getBoolean("vegetarian");
    glutenFree = jb.getBoolean("glutenFree");
    nuts = jb.getBoolean("nuts");
  }

  JSONObject toJson() {
    JSONObject json = new JSONObject();
    json.put("name", name);
    json.put("price", price);
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
