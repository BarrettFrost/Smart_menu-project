This is a draft for desktop app; I uploaded that just because maybe some information would be more proper in the other parts of the README.md
ACCEPT ANY KINDS OF ADVICE^_^
------------------------------------------------------------------------------------------------

*^_^*PROJECT OVERVIEW - PROCESSING
This desktop app is for restaurant chef, which can implement a little bit functions: add new dishes, delete existed menu, send new items to web and register a new restaurant. It could use JSON Package to communicate with the web database, and send the information of dishes including food name, food calories, if it is vegetarian food(use boolean), if contains nuts, if contains gluten(use boolean) as well as restaurant name and ID.

DATA COMMUNICATION:
We use json package to exchange data and information. In the web of MQTT, we use different query id to communicate kinds of information, for example:
[when M5 stack communicate with Web]
As for the desktop app, the users usually send the data containing menu of food in the restaurant! We have a format for this transformation. When new users want to register this restaurant, it should send its reataurant name using this format to the Web and set the queryID is 30; and then the manager of web would return a new json package which contains a new restaurant id and using queryID 31; when this restaurant wants to send the new menu to web after adding, editing or deleting, it would use the same format but set the queryID to 40.

OBJECT ORIENTED DIESGN:
This model is for a restaurent which could connect with web - sending its restaurant name, get its restaurant id and then send its menu items.
So there are at least three main object:
    class Restaurant - which contains (String) restaurant_name, (String) restaurant_id;
    class Food - which contains (String) food_name, (int) food_calories,  (boolean) if_vegetarian, (boolean) ifcontain_gluten, (boolean) ifcontain_nuts;
    class Menu - which contains an arraylist, Food[] foods.
We use these items to make the sytem of a restaurant_menu:
- adding some new food [add_item(), doAdd() function]: pass name, calories,  vegetarian, gluten, nuts as parameters and create a new food object;
- editing existing food [edit_item(), doUpdata() function]: just create a new food object like add_item, and then do some update, to send new items as json package;
- deleting existing food [delete(), doDelete() function]: we use menu object, and delete the selected index;
- doing registration [registration(), doRegister() function]: send menu item in the format of json Package.

PROCESSING ARCHITECTURE AROUND OBJECTS
1.api.pde
- doRegister();
- doDelete();
- doAdd();
- doUpdate();
2.database.pde
- hasLocalRestaurant();
- loadRestaurant();
- loadMenu();
3.events_gui.pde
- registration();
- cancel();
- delete();
- edit();
- add();
- add_item();
- edit_item();

EVOLUTION OF UI 
- EDITION 1.0: have 2 pages for desktop app 
    - A restaurant menu page: show the items of menu, and for registration
    - A registration page: the users can input restaurant name and choose 'register' and 'cancel'
- EDITION 2.0: have 2 pages, which including a restaurant menu page, a registration page 
    - A restaurant menu page: show the items of menu, and the user can select the specific items of this menu, which helps user to delete. Another function in this page is to register.
    - A registration page
- EDITION 3.0: have 3 pages, which including a restaurant menu page, a registration page and a add/edit page
    - A restaurant menu page: the user can select the specific items not only for deleting items, but also for edit items. Totally there are 4 functions in this page: ADD, EDIT, DELETE, REGISTER_NEW (means the regiatration for a new restaurant)
    - A add/edit page: the user could add the information of particular food item into the menu, which includs the name of food, food calories, and set if this food contains meat, nuts and gluten...the user could also edit those information in a page that has the memory of privious food information
    - A registration page
    
DATA PERSISTANCE
We have the need of persist data about menu and single restaurant in the daily life.
We use json file (menu.json, restaurant.json) as API instead of real database. 
In processing desktop, we use functions such as loadMenu() and loadReataurant() to load the json file, and to use this database.
When the user add/edit/delete the food, or register a new restaurant, the data would be changed in the saved json file!

*Data Structure (json)*
- menu.json:
[
  {
    "foodName": "burger",
    "containsGluten": true,
    "containsNuts": false,
    "calories": 30,
    "vegan": false
  },
  {
    "foodName": "salad",
    "containsGluten": false,
    "containsNuts": false,
    "calories": 500,
    "vegan": true
  }
]

- restaurant.json:
{
  "name": "KFC",
  "id": "lawp"
}









