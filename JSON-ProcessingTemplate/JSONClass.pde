//JSON packet CLASS
public class JSONPacket{
 private int queryID;
 private ArrayList<Restaurant> restaurantList;
 private int listSize;
 private Restaurant restaurantSingle;

 //Constructor
 public JSONPacket(){
  queryID = 0;
  restaurantList = new ArrayList<Restaurant>();
  listSize = 0;
  restaurantSingle = new Restaurant();
 }

 //Query ID methods
 public void setID(int qID){
  queryID = qID;
 }  
 public int getID(){
  return queryID;
 }

 //restaurantList methods
 public void addToList(Restaurant res){
  restaurantList.add(res);
  listSize = restaurantList.size();
 }  
 public ArrayList<Restaurant> getList(){
  return restaurantList;
 }

 //ListSize methods
 public int getListSize(){
  return listSize;
 }
  
 //restaurantSingle methods
 public void setResSingle(Restaurant res){
  restaurantSingle.restaurantName = res.restaurantName;
  restaurantSingle.restaurantID = res.restaurantID;
  restaurantSingle.menu = new ArrayList<Food>(res.menu);
  restaurantSingle.menuSize = restaurantSingle.menu.size();
 }  
 public Restaurant getResSingle(){
  return restaurantSingle;  
 }  

 //TEST printing
 public void debugPrint(){
  println("Printing each element in JSONPacket in order. Examine further if any errors arise.");
  println(queryID);
  for (int i=0;i<listSize;i++){
   restaurantList.get(i).debugPrint();
  }
  restaurantSingle.debugPrint();
  }
}

//Restaurant CLASS
public class Restaurant{
 private String restaurantID;
 private String restaurantName;  
 private ArrayList<Food> menu;
 private int menuSize;

 //Constructor
 public Restaurant(){
  restaurantName = "";
  restaurantID = "";
  menu = new ArrayList<Food>();
  menuSize = 0;
 }

 //restaurantID methods
 public void setID(String id){
  restaurantID = id; 
 }
 public String getID(){
  return restaurantID; 
 }

 //restaurantName methods
 public void setName(String name){
  restaurantName = name; 
 }
 public String getName(){
  return restaurantName; 
 }

 //menu methods
 public void addToMenu(Food food){
  menu.add(food);
  menuSize = menu.size();
 }  
 public ArrayList<Food> getMenu(){
  return menu;
 }  

 //menuSize methods
 public int getMenuSize(){
  return menuSize; 
 }

 //TEST print
 public void debugPrint(){
  println(restaurantName + " " + restaurantID);
  for (int i=0;i<menuSize;i++){
    menu.get(i).debugPrint();
  }
 }
}

//Food CLASS
public class Food{
 private String foodName;
 private int calories;
 private boolean vegan;
 private boolean containsGluten;
 private boolean containsNuts;

 //Constructor
 public Food(){
  foodName = "";
  calories = 0;
  vegan = false;
  containsGluten = false;
  containsNuts = false;
 }
 
 //foodName methods
 public void setName(String fName){
  foodName = fName;
 }
 public String getName(){
  return foodName; 
 }
 
 //calories methods
 public void setCal(int cal){
  calories = cal;
 }
 public int getCal(){
  return calories; 
 }
 
 //vegan methods
 public void setVegan(boolean veg){
  vegan = veg; 
 }
 public boolean getVegan(){
  return vegan; 
 }
 
 //containsGluten methods
 public void setContainsGluten(boolean glut){
  containsGluten = glut; 
 }
 public boolean getContainsGluten(){
  return containsGluten; 
 }
 
 //containsNuts methods
 public void setContainsNuts(boolean nut){
  containsNuts = nut; 
 }
 public boolean getContainsNuts(){
  return containsNuts; 
 }
 
 //TEST print
 public void debugPrint(){
  println(foodName + " " + calories + " " + vegan + " " + containsGluten + " " + containsNuts);
 }
}
