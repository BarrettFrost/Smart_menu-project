Smart_Menu

////Preliminary Draft

Smart_Menu is a lightweight and simple Internet-of-Things interface that connects a restaurant menu database directly to user preferences. Combining the functions of a menu database service from food apps (e.g Yelp) and diet trackers (e.g. [insert app here]), Smart users are able to preemptively preview what dishes served in the restaurants fit their dietary profile, making dietary tracking more convenient.

An Overview

A simple summary of the Smart_Menu pipeline across the three platforms (desktop, web, m5 Stack) is as follows:


  a. Desktop: This is the restaurants' end. Restaurants register with the service and upload their menu to the web server.

  b. Web: This is the developer/service provider end. The web service registers restaurants(generates the unique restaurant ID) and stores the database to be accessed by users.

  c. m5 Stack: This is the users' end. Users set their dietary preferences on the app, which then provides assistance when navigating the restaurants registered on the service as they plan their order (e.g. by highlighting dishes that exceed their intended calorie intake or dietary restrictions).

1. System Design [1000 words]:

  a. Architecture of the entire system



  b. Object-Oriented design of key sub-systems (e.g. Desktop Application, Web Application etc.)
  c. Requirements of key sub-systems (in the form of selected user stories)
  d. The evolution of UI wireframes for key sub-systems
  e. Details of the communication protocols in use (including a rational for your choice)
  f. Details of the data persistence mechanisms in use (including a rational for your choice)
  g. Details of web technologies in use (including a rational for your choice)

(b. Object-Oriented design of key sub-systems)

M5 Object oriented design

The smart menu design featured the List and menu classes. Since the menu must be able to display, select and flag an unknown number of restaurant names or menu items, object-oriented design seemed to most appropriate approach.  The code had an array of list and menu once the items have been received via JSON. The classes allow variables associated with each menu item e.g. the name. These variables could then be manipulated for instance selecting an item and using method to change the selection integer or changing the flag depending on Booleans for dietary requirements. 

DESKTOP Object oriented design

This model is for a restaurent which could connect with web - sending its restaurant name, get its restaurant id and then send its menu items.

So there are at least three main object:

    class Restaurant - which contains (String) restaurant_name, (String) restaurant_id;
    
    class Food - which contains (String) food_name, (int) food_calories,  (boolean) if_vegetarian, (boolean) ifcontain_gluten,    (boolean) ifcontain_nuts;
    
    class Menu - which contains an arraylist, Food[] foods.
    
These functions make the system of a restaurant_menu:

  - adding some new food [add_item(), doAdd() function]: pass name, calories,  vegetarian, gluten, nuts as parameters and create a new food object;
  - editing existing food [edit_item(), doUpdata() function]: just create a new food object like add_item, and then do some update, to send new items as json package;
  - deleting existing food [delete(), doDelete() function]: we use menu object, and delete the selected index;
  - doing registration [registration(), doRegister() function]: send menu item in the format of json Package.
  


Communication protocols  

(e. Details of the communication protocols in use)

The JSON structure can be seen in the diagram above. The queryID JSON Number was used so that each system could determine whether they should ignore the JSON string or interpret the string. For instance, when the M5 stack sends a queryID = 10 to request a restaurant list, the desktop app will ignore the query but the web app will have an if statement to interpret the contents and send back a list of restaurants. The resList is an array of JSONObjects which stores the information about the restaurant such as name, ID and menu Array of JSONObject. The menu JSONObject stores information about the individual foods in the menu. These two arrays store information that will be useful for the user to inform them in their food choices.  The restaurantSingle Object is identical to resList only it is not an array and only stores the information of one restaurant. This was done to make the code in the M5 stack have less nesting and easier to understand. The menuSize and listSize JSON integers were also used to make coding easier as when displaying the items in a list in a for loop. Lastly, the conID integer was a random digit from 1-1000. This was used to make sure when multiple m5 stack were contacting the MQTT server they would only  M5 stack would interpret the JSON string. 

As for the desktop app, the users usually send the data containing menu of food in the restaurant! We have a format for this transformation. When new users want to register this restaurant, it should send its reataurant name using this format to the Web and set the queryID is 30; and then the manager of web would return a new json package which contains a new restaurant id and using queryID 31; when this restaurant wants to send the new menu to web after adding, editing or deleting, it would use the same format but set the queryID to 40.


(f. Details of the data persistence mechanisms in use)
 M5 Data persistence 
 
 The ardiuno-esp32 Preferences library allowed us to save the contents to flash memory on the M5 stack for permanent storage. This was necessary for the M5 stack to save the user dietary requirements, maximum calories per meal and the contents of the order they want to place. The preferences library had partitioning for the variables and each variable could be assessed using a key. The dietary requirements were saved as integers with 0(false) and 1(true). The max calories were saved as integer as well and the menu items and restaurant name were saved as a string.

 DESKTOP Data persistence 
 
 - We have the need of persist data about menu and single restaurant in the daily life.
 - We use json file (menu.json, restaurant.json) as API instead of real database. 
 - In processing desktop, we use functions such as loadMenu() and loadReataurant() to load the json file, and to use this database.
 - When the user add/edit/delete the food, or register a new restaurant, the data would be changed in the saved json file!
 
  ATTENTION: *Data Structure in json* would be uploaded in processing/data folder!
  
  - menu.json:
[
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
  

Brief Overview of M5

The M5 stack was designed to be a smart menu. There are three main task the menu had to accomplish. One was to record the dietary requirements of the user and set the maximum calories per meal. The other was get the restaurant list and menu items for that restaurant and flag any items that do not meet the dietary requirements and when the meal is over the calories limit. Lastly the menu must be able to save and display the last selected menu items. 

Brief Overview of DESKTOP

This desktop app is for restaurant chef, which can implement a little bit functions: add new dishes, delete existed menu, send new items to web and register a new restaurant. It could use JSON Package to communicate with the web database, and send the information of dishes including food name, food calories, if it is vegetarian food(use boolean), if contains nuts, if contains gluten(use boolean) as well as restaurant name and ID.


2. System Implementation [1000 words]:
  a. Breakdown of project into sprints (showing the users stories implemented in each).

The project first began with work on the users' (m5) end. Once we settled on the general direction of our project (a combined menu browser + diet tracker) we started to outline what 'front-end' features such an interface would include. We initially envisioned a system that worked locally in the restaurant, where participating restaurants would encode the food date onto a unique identifier on each dish (conceptually, a QR code, or colored plate e.g. a sushi bar), to be scanned by restaurant patrons when ordering. This is captured by the captured footage of the paper prototype:

This idea was quickly scrapped and we moved to a fully online system. Among other reasons, we considered the burden of implementation for restaurants to be far too high. We also realized that the physical step was unnecessary. Put simply, they would achieve the intended result of recording their meal by saving it from the menu on the app, without the need for local verification.

[Something about the stages of designing the basic layout of the m5]



  b. Details of how you evaluated your designs (techniques used & awareness of their limitations)
  c. Discussion of Social and Ethical implications of the work

3. Project Evaluation [800 words]:
  a. Reflective discussion of the success of the project
  b. Discussion of future work (in terms of design, development and evaluation)
  c. Reflect on the working practices of your group, how well they did or did not work, e.g, management of issues, communication, Agile (etc).
  d. This is a chance to reflect on how coronavirus has affected your project (remote working practices etc)

The project was a success, so far as achieving its intended goals. We successfully implemented all the primary intended features, most crucially in a manner that was conducive to future iteration and improvement.

Among considered directions for future work would be a persistent database for the web server. This would certainly be essential in a true final commercial product but was excluded in our project scope. This would likely be a sim. Another significant additional function would be a feedback/report system. There is currently no built in form of communication between the intended user groups. While it was excluded on the grounds that it's not a core feature, this functionality is important in any commercial ready product to collect userbase feedback and communicate sentiment/service disruptions. Finally, significant additional UI/UX work could be made to make the product more visually appealing.

The group worked well to accomplish its goal despite numerous challenges. Our design sprints demonstrate that we practiced AGILE design principles from the very start, steadily building up our product in layers and organizing 'functionality test' meetings regularly.


////Unedited Assignment Brief

1. System Design [40pts]:
  a. Architecture of the entire system
  b. Object-Oriented design of key sub-systems (e.g. Desktop Application, Web
    Application etc.)
  c. Requirements of key sub-systems (in the form of selected user stories)
  d. The evolution of UI wireframes for key sub-systems
  e. Details of the communication protocols in use (including a rational for your choice)
  f. Details of the data persistence mechanisms in use (including a rational for your choice)
  g. Details of web technologies in use (including a rational for your choice)

2. System Implementation [40pts]:
  a. Breakdown of project into sprints (showing the users stories implemented in each).
  b. Details of how you evaluated your designs (techniques used & awareness of their limitations)
  c. Discussion of Social and Ethical implications of the work

3. Project Evaluation [20pts]:
  a. Reflective discussion of the success of the project
  b. Discussion of future work (in terms of design, development and evaluation)
  c. Reflect on the working practices of your group, how well they did or did not work, e.g, management of issues, communication, Agile (etc).
  d. This is a chance to reflect on how coronavirus has affected your project (remote working practices etc)
