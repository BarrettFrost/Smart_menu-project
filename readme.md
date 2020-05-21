<div align=center><img width="550" src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/logo2.png"/></div>

## Smart_Menu

#### Smart_Menu is an Internet of Things (IoT) solution that matches your dietary needs directly with what's on the menu ! Combining a menu browser (common in food finding apps, e.g Yelp) with a diet planner (e.g. Mealime), Smart_Menu makes planning your next meal safer and more convenient than ever before.

<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/head_pic2.gif" width="600">
</p>

## Contents  
- [System Design](#System-Design)  
  - [Architecture](#Architecture)
  - [Overview of System](#Overview-of-System)
    - [M5](#M5)
    - [DESKTOP Application](#DESKTOP-Application)
    - [Web Application](#Web-Application)
  - [JSON Model](#JSON-Model)
  - [Communication protocols](#Communication-protocols) 
  - [Object-Oriented design of key sub-systems](#Object-Oriented-design-of-key-sub-systems) 
    - [M5](#M5)
    - [DESKTOP Application](#DESKTOP-Application)
  - [Requirements for key sub-systems](#Requirements-for-key-sub-systems) 
  - [The evolution of UI wireframes for key sub-systems](#The-evolution-of-UI-wireframes-for-key-sub-systems) 
    - [M5](#M5)
    - [DESKTOP Application](#DESKTOP-Application)
    - [Web Application](#Web-Application)
  - [Data Persistence](#Data-Persistence) 
    - [M5](#M5)
    - [DESKTOP Application](#DESKTOP-Application)
  - [Web Technologies](#Web-Technologies) 
- [System Implementation](#System0-Implementation) 
  - [Project sprints](#Project-sprints) 
    - [Sprint 0, or Ideation](#Sprint-0,-or-Ideation) 
    - [Sprint 1: M5  & DESKTOP Design](#Sprint-1:-M5-&-DESKTOP-Design) 
    - [Sprint 2: Web Application, MQTT testing](#Sprint-2:-Web-Application,-MQTT-testing(Late-Feb---Early-March)) 
    - [Sprint 3: JSON packet, MQTT](#Sprint-3:-JSON-packet,-MQTT) 
    - [Sprint 4: functionality testing, Desktop applicationg](#Sprint-4:-functionality-testing,-Desktop-application)
    - [Sprint 5: Polishing, Full project testing](#Sprint-5:-Polishing,-Full-project-testing) 
  - [Design Evaluation](#Design-Evaluation)
    - [Technique used](#Technique-used)
    - [Limitations](#Limitations)
    - [Sample: M5 Final evaluation](#Sample:M5-Final-evaluation)
  - [Social and Ethical Implications](#Social-and-Ethical-Implications)  
- [Project Evaluation](#Project-Evaluation) 


## System Design:

### Overview of System

When you want to go out for something to eat sometimes the choice can be overwhelming and many establishment may not meet your requirements. For instance, if you are a vegan or watching your weight then a restaurant with limited choice of vegan options or high caloric foods wouldn't be a good choice to spend the evening there. Research into the restaurants can take up precious time. A system that could filter based on preferences could lessen this time needed to conduct the research. The restaurants business can be very stressful especially when introducing new items to the menu. Most restaurants nowadays still have there menus on paper and this makes updating very time consuming as you have to print out a new sets of menu everytime the menu changes. The system that could make this easier could help restaurants during those challenging times.    

We have developed a system that can solve these issues for the restaurant industry. Firstly the system will be initiated by a customer using the IOT device to find a meal from a restaurant. Before doing so, They would have first set their dietary preferences and desired calories per meal. The customer would then query the Web Application for a list of restaurants from the company running the system. They would then select the restaurant they want to order food from and send that information to the company. Then the company would ask the restaurant owner for the menu. After the company would relay this menu to the customer which they would choose their meal and save their order.

 <p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/Untitled%20Diagram-7.png" width="700">
</p>



### Architecture

![UML Diagram](https://github.com/BarrettFrost/Smart_menu-project/blob/master/UML2.0.png)

Our architecture shown above illustrates how information moves between Web App: service Provider, M5: user, Desktop: restaurant. This allows us to send menus with each dishes details and restaurant lists with individual details over a network, which is essential to menu browser apps. Additionally each section of the system has individual functions to request and obtain data via JSON string. Once the data is obtained each section can use the data to it's need.  

[Back to contents](#Contents)


#### *M5*
 M5 is an IoT device which will be used as the smart menu. The user will use it to flag items which doesn't meet their dietary needs or if the meal is too high in calories. For example, user could set there max carlorie intake per meal and any order over 800 calories would be flagged. If the user may have the preference of vegan, the M5 will any flag any items which are non vegan. This M5 device has addressed the problem of how to help the customer to select the healthier food.

 The interface of M5 Stack is relatively complex, which includes 3 different branches:
 1. choose customers' preference: a main menu, a page to save/set calories, and a page to save/set dietary preferences 
 2. order meals: a page to show the list of restaurant, a page to show the smart menu, and a page to show the selected menu
 3. save orders: a page to dispaly the saved order

 When the user is ready to get some orders, he/she would first set the calories per meal and choose their dietary requirement and this will be saved to permanant storage. Then the user could choose the restaurant they want to see the menu from and the M5 stack would send the request to the service provider. The service provider will respond with a list of restaurant lists. After the restaurant is chosen by the user, M5 stack will request the menu from the service provider. Once the menu is recieved the food items that meet the dietary requirements of the user will be flagged. The user would then choose there meal and the M5 would display there raise a flag if the meal is over the max calroies value. The user could then save his chosen meal the permanant storage for reference. 

   #### *DESKTOP Application*
 The application for desktop is an menu management system for restaurants. It will help the restaurant to quickly make some changes for to the menu by providing ADD/EDIT/DELETE function for dishes. For example, if the chef wants to add a new dish for reataurant, he could directly edit the menu in the desktop app in his kitchen. The new menu would send to the company and then that new dish would be updated in the smart menu device!

 The interface of desktop has a main page in which the users(chef in the kitchen) could choose some items and add/edit/delete dishes. Another page of that is a registration page for a new user to send its reataurant name to the service provider. 

 The restaurant can register with the service providing its name. The service provider will then send back a new restaurant id to the desktop all. This information would be saved in JSON String "SingleRestaurant", and every time when this restaurant would like to send a menu to the company, this restaurantID would be used as a key between the service provider and the restaurant. 

 #### *Web Application*
 Web application, is the service provider, this app is used to record all of the restaurants which have resgistered with the system. The app can be seen as bridge between the M5 devices and the desktop apps. When the M5 device send the restaurant list or menu request to the MQTT, the web would respond and send the specific list back to it. The web app will receive the menu and restaurant name from the restaurant, and give the same menu to the users when requested.

 The interface of web application includes a page that displays a table of restaurants and a page that desplays the menu of the reataurant.

[Back to contents](#Contents)


### JSON Model
```
<pre> type query struct{
     queryID         int         'json : "queryID"'
     converstionID   int         'json : "conID"'
     listSize        int         'json : "listSize"'
     restaurantList  *restaurant 'json : "resList"'
     restaurant      restaurant  'json : "restaurantSingle"'
}

type restaurant struct{  
     restaurantName  String     'json : "resName"'
     menuSize        int        'json : "menuSize"'  
     restaurantID    int        'json : "resID"'
     menu            *menu      'json : "menu"'
}

type menu struct{  
    foodName       String      'json : "foodName"'
    containsGluten Boolean     'json : "containsGluten"'
    containsNuts   Boolean     'json : "containsNuts"'  
    veganFood      Boolean     'json : "vegan"'   
    calories       int         'json : "calories"'  
}  </pre>
``` 
For the networking aspect of the system to most important information was to send menu items over the network. This so the smart menu could get the most up to data menu from the restaurant to user wants to visit. Since the restaurant's desk top app had the most up to date menu and the smart menu doesn't contain any, this justified the networking aspect of the project. The smart menu also needed to able to obtain different menu from different restaurants. The webapp was needed to relay the menu from the requested restaurant from the list of resgistered restaurant it has on its system. Since mulitiple smart menu devices would be in circulation in the live product there also needed to be mechanism to only send information to one particular device that makes a request.  

The JSON structure can be seen in the diagram above. The **queryID** JSON Number was used so that each system could determine whether they should ignore the JSON string or interpret the string. For instance, when the M5 stack sends a queryID = 10 to request a restaurant list, the desktop app will ignore the query but the web app will have an if statement to interpret the contents and send back a list of restaurants. The **resList** is an array of JSONObjects which stores the information about the restaurant such as name, ID and menu. The **menu** is a JSONObject which stores information about the individual foods in the menu such as calories, name and etc. These two arrays store information that will be useful for the user to inform them in their food choices. The **restaurantSingle** Object is identical to resList only it is not an array and only stores the information of one restaurant. This was done to make the code for the M5 stack have less nesting and easier to understand. The **menuSize** and **listSize** JSON integers were also used to make coding easier because the items are being displayed from a for loop. Lastly, the **conID** integer was a random digit from 1-1000. This was used to make sure when multiple IOT devices were contacting the MQTT server they would only one IOT device would interpret the JSON string. From *the UML diagram* you able to see which system is sending and using each part of the JSON.

<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UML2.0.png" width="700">
</p>


[Back to contents](#Contents)

### Communication protocols  

Our communication protocol is simple, relying on two variables, queryID and conID, stored in our JSON packet to distinguish packets. queryID is a two digit integer sequence that identifies the type of query. The first digit in the sequence denotes the query type, while the second digit, either '0' or '1', denotes when the packet is a query or a reply ('0' = query, '1' = reply).

- **The interaction process between M5 Stack and the web:** When customers use M5 Stack, they need to first select the restaurant they want they want to see the menu. M5 Stack at this time will send a JSON Package to MQTT, setting the queryID == 10. If the service provider will respond and return a list of reataurants to this M5 Stack, with the queryID == 11. After selecting their restaurant, the M5 will request a menu from that restaurant with a queryID == 20. This menu would be sent from the company which uses the web application with a queryID == 21. This is the whole process of how a customer may order their food in a restaurant and how M5 Stack and web application would interact with each other during this period of time.

- **The interaction process between the desktop and the web:** When a restaurant owners want to register their restaurant with service provider, the desktop application would send a JSON Package with the queryID == 30 and its restaurant name. After that, the service provider will respond and approve this restaurant, it would generate a new reataurant id and return the queryID == 31. Sometimes it would be necessary to update the menu of this reataurant, at this time the restaurant would just need use the ADD/UPDATE/DELEE functions in app, and then the desktop application would send the updated menu list to the web, setting the queryID == 40. And the web application would receive this updated menu and update its databases after that. 

- 10: M5 requesting restaurant list from web application. Reply: 11
- 20: M5 requesting menu from selected restaurant. Reply: 21
- 30: Desktop app (restaurant) registering with the web server. Reply: 31
- 40: Desktop app (restaurant) updating information with the web server. Reply: 41

conID serves to identify unique conversations between devices. This ensure that replies are received and read properly.

[Back to contents](#Contents)

### Object-Oriented design of key sub-systems

All of our sub-systems were built around principles of object-oriented design. The reasons for this were obvious to us: we would be working predominantly with abstract data types, and handling multiple instances of the same objects, ('restaurants' and 'food'). Standardizing on OOP would also allow us to homogenize across all the subsystems, keeping things simple to understand and easy to debug.

Excepts from our m5 and Desktop application design, that were most driven my these principles, are as follows:

#### *M5*

The smart menu design featured the List and menu classes. Since the menu must be able to display, select and flag an unknown number of restaurant names or menu items, object-oriented design seemed to most appropriate approach.  The code had an array of List and menu objects once the items have been received via JSON. The classes allow variables to be associated with each menu item e.g. the name. These variables could then be manipulated, for instance selecting an item and using method to change the selection integer or changing the flag depending on Booleans for dietary requirements.

#### *Desktop Application*

The processing part of this project was developed based on Object-Oriented design. However, object-oriented design can make the program easier to maintain and extend.

The desktop app was designed for use in restaurant and needed to be able to save, edit, delete and add food to a menu and eventually send the menu over an network. Object oriented programming is perfect to implement these features in code. For instance for the food object we are able the contain all the qualities of the food object in one object eg calories and name. The menu object contained an array of foods and methods used to add and delete certain foods and to transform food data into a JSON array for the networking aspect of the system. Since all food data was in the food object this allowed the transfer of data extremely easy. 

The application uses three main objects:

- *Restaurant* contains (String) restaurant_name, (String) restaurant_id;
- *Food* contains (String) food_name, (int) food_calories,  (boolean) if_vegetarian, (boolean) ifcontain_gluten,    (boolean) ifcontain_nuts;
- *Menu* which contains an arraylist, Food[] foods.
  
  <p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/OOPprocessing.png" width="700">
</p>


[Back to contents](#Contents)

### Requirements for key sub-systems

An overview of the key requirements of our sub-systems (desktop, web, m5 Stack) were decided as follows:

- The Desktop Application represents the restaurants' end. It would need to be able to register with the service, and be able to upload/update their data, e.g. name and menu, on the database.
- The Web Application represents the developer/service provider end. It would need to handle restaurant registration and the service's database.
- The Arduino/m5 Stack represents the consumer end. It has two primary feature. The first is allowing users to configure their dietary preferences. Next is recording an order. the M5 accesses and browses restaurant menus saved on the web application. The user's configured preferences should be read as the order is made, e.g. by flagging dishes that exceed their intended calorie intake, or contain unsafe ingredients.

[Back to contents](#Contents)

### The evolution of UI wireframes for key sub-systems

#### *M5*
#### *Preferences Branch:*
<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/M5%20pictures%20graph/ui%20preferences.PNG">
</p>

#### *Order Branch:*

<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/M5%20pictures%20graph/ui%20restaurants.PNG">
</p>

<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/M5%20pictures%20graph/ui%20menu.PNG">
</p>

#### *Saved order branch:*

<p align="center">
  <img src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/M5%20pictures%20graph/ui%20saveOrder.PNG">
</p>

For the UI of the smart menu needed to display multiple different types of information such as setting calories and dietary requiments and listing and flagging menu items. Also the user has to able to easily use the device without any prior knowledge of said device. Since the M5 was small this information needed to be diveded between pages. Due to the limited buttons we had to divide access to pages between 3 separate branches as seen from the diagrams above. There is a consistent layout for all pages to make the user experience more intuitive. This layout consisted of a title at the top and below displayed whatever functions the page served. At the bottom there are buttons squares with names attached describing the certain function of the button, whether it be moving to another page or saving an order. The buttons on screen were designed to line up with the buttons on the physical device so that the user knew which button did what. For the flagging of menu items red circles was chosen to be used. The M5 stack provides several ways to do this but it needs to be non-obtrusive and striking. The red colour draws the user’s attention and the small circle does not take up too much space.

[Back to contents](#Contents)

#### Desktop Application

- v1: 2 pages
    - A restaurant menu page: show the items of menu, and for registration
    - A registration page: the users can input restaurant name and choose 'register' and 'cancel'
    ![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/desktop_videos/v1.png)
In this version 1.0, desktop firstly implement two functions - registration and showing the main menu. When a new user open this desktop application, he would firstly add his restaurant name into this app, and then click register. This process let the desktop app send a json string which has the new restaurant name in it, and then this app would receive a json package from the web in which contains its restaurant id. After receiveing this restaurantID, this desktop application would switch into the second page, which could show the information of this restaurant.

- v2: 2 pages
    - A restaurant menu page: show the items of menu, and the user can ADD and select the specific items of this menu, which helps user to delete. 
    - A registration page (which has been implemented before)
    ![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/desktop_videos/v2.png)
In this version 2.0, we prioritized the add new function, because this is the most basic one for samrt menu; we also add the select function, which could help restaurant to choose specific dishes. This choose function could be used for DELECT/EDIT functions in version 3.0.


- v3: 3 pages
    - A restaurant menu page: the user can select the specific items not only for deleting items, but also for edit items. Totally there are 4 functions in this page: ADD, EDIT, DELETE, REGISTER_NEW (means the regiatration for a new restaurant)
    - A add/edit page: the user could add the information of particular food item into the menu, which includs the name of food, food calories, and set if this food contains meat, nuts and gluten...the user could also edit those information in a page that has the memory of privious food information
    - A registration page: also we implement REGISTER function this time in the main page.
    ![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/desktop_videos/version%203.png)
    In this version 3.0, we use the select function to implement further functions, like EDIT/DELETE. If the users doesn't select an item before edit/delete dishes, the system would have a warning - to remind the users that nothing has been selected.

[Back to contents](#Contents)

#### *Web Application*

- v1: html table
The Web Application started with a basic html table that displayed all entities in the arrayList *resTable*. The table was created dynamically from the objects in the table: table headers were variable of the restaurant JSONObject (resID, resName).

```
  var col = [];
  for (var i = 0; i < resTable.length; i++) {
      for (var key in resTable[i]) {
          if (col.indexOf(key) === -1) {
              col.push(key);
          }
      }
  }

  //
  for (var i = 0; i < col.length; i++) {
      var th = document.createElement("th");     
      th.innerHTML = col[i];
      tr.appendChild(th);
  }
```

While a flashy implementation, this meant that the headers were ugly variable names. Also, this didnt work for object variables, like *menu* (would show as 'undefined')

![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/webapp%20photos/webapp%20home.png)

- v2: Improvements, Bootstrap
Basic improvement to fix the issues above. the dynamic header *col* was replaced with fixed header names. *menu* was removed pending implementation of a separate menu table.

Bootstrap framework was added. Bootstrap was used to add responsive features to the table, and modify the color scheme/font to be more appealing

```
  function createTable(){
    ...
    var table = document.createElement("table");
    table.className='table table-striped table-bordered';

    //create table headers
    var tr = table.insertRow();
    tr.className='thead-dark';
    ...etc.
  }
```

- v3: Menu table
Added a second menu table. a *menu* button was added to each entry for the restaurant table, which would load the restaurant's menu.

```
  tabCell.innerHTML = "<button type='button' class='btn btn-light' onclick='createMenu(this)'>see menu</button>";
```

Adding the second table caused clipping issues even though the tables were responsive. This was because the sheer size of the two tables would take up the whole window.

![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/webapp%20photos/menu%20hor.png)

- v4: Bootstrap containers
The last addition was a responsive layout with containers, to solve the above issue. Now when the window was resized, the second table would move below the first if there was not enough space.

```
  <div class='container'>
    <div class='row'>
      <div class='col-lg'>
        <table class='table' id="showrestaurants" name="showrestaurants"></table>
      </div>
      <div class='col-sm'>
        <table class='table' id="showmenu"></table>
      </div>
    </div>
  </div>
```

![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/webapp%20photos/menu%20vert.png)


[Back to contents](#Contents)

### Data Persistence

The M5 and Desktop Application have data persistence.

#### *M5*

The ardiuno-esp32 Preferences library allowed us to save the contents to flash memory on the M5 stack for permanent storage. This was necessary for the M5 stack to save the user dietary requirements, maximum calories per meal and the contents of the order they want to place so they wouldn't need to submit there preferences everytime they switched the device on. The preferences library had partitioning for the variables and each variable could be assessed using a key. The dietary requirements were saved as integers with 0(false) and 1(true). The max calories were saved as integer as well and the menu items and restaurant name were saved as a string.

#### *Desktop Application*

 The application needed to save the menu so restaurant manager didn't have to re-register and remake their menu every time the system was closed. This was implemented by saving the data as a JSON file. Functions (loadMenu(), loadRestaurant()) would run at initialization to load data from the save files. Lastly, whenever the user edited the data, e.g. registering as a new restaurant or changing the menu, the changes will also be written into the JSON save file!

- [Back to contents](#Contents)

### Web Technologies

 The website is built with the three standard languages: HTML, CSS and Javascript. They were chosen because of the extensive support material available (online tutorials through Youtube, w3schools, geeksforgeeks, etc.). Choosing a well supported language set helped speed up the learning process, leading to a shorter development time. It was also good practice to work with industry standard languages and built familiarity for use in future projects.

 The primary browser used throughout development was Google Chrome, due to its ubiquity and light weight. The built in DevTools were also very helpful for debugging, especially for Javascript as an interpreted language. However, we also tested our site to work with Firefox.

 Our framework of choice was Bootstrap. With Bootstrap, it was extremely easy to quickly implement useful UI features. The three main features of Bootstrap that were used was styling, containers and improved tables. First, working with and modifying Bootstrap's styling made the process of setting and changing fonts and colors much quicker than if we were to build our own stylesheet from scratch. Next, Bootstrap's containers were particular helpful at building a responsive layout that could wrap our page's elements to any screen size (prior to implementing Bootstrap's layout features, we had a lot of problems with text clipping given that our web page is dominated by two large tables). Finally, Bootstrap's tables tags allowed us to easily make our tables visually appealing and responsive.

 Finally, we used the mqtt plugin by paho to implement mqtt functionality into our site.

[Back to contents](#Contents)

## System Implementation:

### Project sprints

#### Overview

We structured our design schedule to keep pace with the teaching material. We would meet at the start of the sprint to determine the intended design objectives. This took the form of in person meetings initially, transitioning to conference calls with the coronavirus outbreak.

Upon determining a major feature we wanted, the tasks would be broken down to as many constituent parts and steps as possible, to be spread across several sprints. This was practising AGILE development: by staging our design process, our work plan was flexible, adaptable to if things were faster OR slower to build than expected (though overall, our project mostly keep to the predicted schedule). Also, our systems would compile and work at every step, rather than only coming together at the end.

Each sprint lasted 2-3 weeks, to account for planning, building and testing at each step. The exception was the final polishing, which was more fluid and involved more regular meetings as we made sure that final work had not inadvertedly broken any prior functionality.

#### *Sprint 0, or Ideation (late Jan - early Feb)*
Our project began at the ideation step. During initial brainstorming, once we'd decided that our project would be dietary related, We settled on two user stories that define our goals.

- [the m5 user] wants to be able to be able to record his meals, to be more calorie conscious when eating.
- [the m5 user] wants to tell what ingredients are in dishes before ordering, to avoid dietary allergies.

Based on these goals, we decided that combining a diet tracking function and a dish ingredients filter would achieve these goals. We initially envisioned a system that asked users to scan their meal as they ordered: restaurants would tag their dishes with identifiers(a QR code or colored plate, ala a sushi bar) to be scanned using a camera. This may be seen in our paper prototype demo:

<div align=center><img width="550" src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/sprits0.gif"/></div>

We scrapped this idea after receiving negative feedback during user testing. This was a learning experience for us. The user testing consisted of a paper prototype of the proposed product. We wanted to see whether the participants could use the product without any guidence. But our participants found the scanning the colored plates to be unintuitive and too much hassle than it was worth. We also questioned the burden of implementation for restaurants to be too high and would turn them off from participating. During this time the group learned how to perform networking with the MQTT for the M5 stack. Also, learned how to use displays in M5 and processing. For instance display text or spuares and creating buttons in each respective platform. 

<div align=center><img width="550" src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/sprits0.1.gif"/></div>

#### *Sprint 1: M5 & DESKTOP Design(Feb)*

Based on the feedback to our demo, we replaced our scanner feature with a simple menu browser in the app, which still achieved our desired end goal. The lesson that we took in making this decision was that users preferred the most intuitive approach over technical sophistication. Case in point, we had initially rejected the menu solution because of a known limitation, namely that by not pushing users to record the meal right then and there, they might forget to record it later. However, our experiences in testing showed that this was preferable as with a more finicky solution, users might be too inconvenienced and just not bother to use the service entirely.

Next, we aimed to build the M5 application during this sprint. This was a continuation of our ideation step (we were simply building our paper prototype). Because we had tested the device in paper form, building the application went smoothly. For the M5 implementation to be sucessful several new techniques has to be learned. To display the lists object oriented programming in the ardiuno (which was like C++) had to learned. Also to implement the saving feature for the M5 the preferences.h library has to be understood. The testing of the individual M5 involved printing output to the serial monitor to check if the feature was working as intended, for instance the integer for calories set.  Once completed, we critiqued the build to plan for further improvements. Not all our ideas would be completed by the end of the project. For instance, we would have liked to build a 'help' or 'tutorial' tool, but could not find an elegant way to implement it considering the M5's limitations, namely the small screen size and limited buttons (discussed in evaluation).

We also thought through how the system could be implemented and could connected with each other. The Web application has been designed as a service provider who can send the menu to the M5. Desktop app, as the restaurant side, would send the menu and update to the web service provider.  We designed some functions for example adding the new meal and updating the menu, showing the main page of all the dishes, and registering a new restaurant. The desktop user interface design *below* could helped us test some ideas to build the best system.

 <div align=center><img width="550" src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/UMLdiagrams/processingUI.gif"/></div>

#### *Sprint 2: Web Application, MQTT testing(Late Feb - Early March)*

With a working M5 program, we moved to build the web application, and experiment with sending JSON packets through MQTT.

We started with our user story for allowing users to browse restaurants and find what to eat:

- [the m5 user] wants to find out what's on the menu at local restaurants in one location, to save the hassle of browsing different sites or having to leave his home.

From this, we decided that the web app's primary feature would be hosting a database of restaurants on the service, to be queried by the m5. Correspondingly, we also added an extra page on the m5 to browse a restaurant list.

We learned how to use API by processing and send JSON String to MQTT after determining the mains functions of desktop app.

Because our networking features were not implemented yet, we were using dummy templates at this step. We had the local functions working using placeholders, allowing us to test and critique them. This would also save us debugging effort later when said networking code was added, as we would expect the local features to be working properly.

When experimenting with MQTT and M5 a problem was discovered the M5 could only accept a certain number of characters via JSON from MQTT. This was issue because our JSON String we quite long due the all menu items and each indivual items data. With some research it was discovered that the PubSubClient library has a max MQTT JSON Packet size of 256. This was subsequently increased to 1000. By the end both the m5 and web app were capable of sending dummy text to the mqtt broker by the end of the sprint.

#### *Sprint 3: JSON packet, MQTT (March)*

This sprint's big goal was "connecting the halves": we completed mqtt implementation between the M5 and the Web app.

We started by finalizing the structure of our JSON packet (see Architecture). Once this was done, we wrote a packet class template (in Processing), which was then converted into the respective subsystems' languages for use. Starting from the same template saved work and minimized confusion: everyone knew that each subsystem would have the same variable names AND functions.

Modifying our MQTT code to send and receive the packet, over dummy text, took no effort at all as it was all a single string. Similarly, as we had already built our local functions to read a dummy packet, it only took some minor modification, to account for the final changes to the JSON structure and read JSON packets from MQTT traffic rather than an offline dummy.

#### *Sprint 4: functionality testing, Desktop application (March)*

Two goals were achieved for our fourth sprint. Firstly, we began UI work and debugging on the m5 and Web App. We also began to work on the Desktop Application, meant to represent the restaurant.

To improve the UI of the web application, we implemented the Bootstrap framework. This allowed us to quickly modify cosmetic features like layout and color scheme, and add advanced features like window responsiveness.

We conducted our first tests between the M5 and Web Application. During the test, we fixed minor bugs, such as accidental differences in capitalization for variable names between the different environments (which wouldn't be recognized by the other subsystem). Overall, testing went smoothly.

Building the Desktop Application was straightforward as we already had a clear idea of the features we wanted(at this point, we were already using dummies on the web Application to simulate traffic from it). Our user stories were:

- [the restaurant user] wants to upload their menu online, to be browsed by its customers.
- [the restaurant user] wants to easily edit their data, so using the service will not be a hassle.

We knew that each restaurant had to have a unique key. Relying on restaurant name *resName* wasn't sufficient as restaurants could have similar names. It is also good practice to not have the key be user editable as it can lead to database corruption. So we implemented a random read-only alphanumeric key *resID* generator on the Web Application that would add a unique key whenever a restaurant registers with the service. This key was then checked whenever a restaurant wished to update their data.

#### *Sprint 5: Polishing, Full project testing (Late March - April)*

This (final) sprint roughly encapsulated our several weeks of final testing, debugging and polishing.

Notable changes made during this stage was adding the *conID* variable. We realized in our testing that we had overlooked the need to identify unique conversations between devices. This was crucial to allow multiple simultaneous conversations to happen without disrupting each other (e.g. one M5 requesting the restaurant list would cause all M5s on the network to receive the response).

*conID* was a random 4-digit integer generated on the M5 whenever it sent a query. To reduce the risk of corruption and tampering, we made *conID* a read-only variable. The Web Application simply copies the ID from the inbound query to the outbound response. the M5 also forgets the ID at the end of the conversation.

[Back to contents](#Contents)

### Design Evaluation

#### Technique used

We primarily relied on a pass/fail technique when evaluating our design. This meant that we would follow up each sprint with an evaluation of whether we'd met our objectives (most often right during, or before, our next meeting). An example of a checklist for assessing our mqtt implementation looked like:

//Sprint goals
- 1) Can the app save JSON packets to file? Y/N
- 2) Can the app load JSON packets from file? Y/N
- 3) Can the app receive an mqtt message? Y/N
- 4) Can the app parse the mqtt message as a JSON file? Y/N

...and so on.

We favored this technique for many reasons. Firstly, it kept us focused on achieving our core requirements. Secondly, it made it easy for all members on the team to communicate and understand the stages of development for each subsystem despite the distribution of work. Finally, it ensured that we abided by the agile design principle of 'just good enough', and did not waste manpower on unneccesary feature bloat. Progress was continuous and clearly visible at every step. Where this was most obvious was in our work on networking/mqtt implementation. We built the local functions in sprint 1, dummy networking in sprint 2, and connected the halves in sprint 3. This way, not only were we constantly testing at every step to ensure that the subsystems functioned, there was also less dependency between the two codeblocks, i.e. a much easier time debugging later.


#### Limitations

Some notable limitations was a lack of attention paid to user comfort. With hindsight, our binary pass/fail system was poorly suited to assess more nuanced features like user comfort and interface. Taking an technical approach to assessing all aspects ("Does X feature work?") probably contributed to why our UI work is quite sparse. Another limitation was the limits to outside input. By sticking rigidly to testing according to our sprint checklists, we limited opportunities for testers to give us more general feedback.

Overall, considering that our goal was to design a prototype than a final product, we accept the compromise that our evaluation technique brought. It greatly lubricated our workflow, minimizing the impact of the quarantine on our project. Working to rigid requirements also kept our development process lightweight and quick, rather than being bogged down with obsessing to work to arbitrary standards. However, we acknowledged that it led to an underprioritization of less 'technical' features, like visual work. In retrospect, It would have likely been possible to transition from a binary to a scaled detailed assessment criteria, e.g. a evaluation matrix, towards the final stages of the project once the core requirements had been satisfied.

---

##### Sample: M5 Final evaluation

*All the main functions of the M5 were successfully implemented and during the testing of the system the M5 performed as intended. An issue may arise if the M5 does not receive a response back from the MQTT broker as the M5 does not notify the user when this has occurred. Notification IS given if the device failed to establish an internet connection.*

*The M5's small screen size affected usability. We had to use the smallest text size to fit as much menu items in the screen as possible. But this may cause difficulty in reading for some users and there had to be a limit on the number of menu items. Another UI issue was the cursor had to be made from a line which once again might be difficult to see. Overall, the M5 is intuitive for the user due to the consistent layout.*

*Data persistence was successful for dietary requirement and max calories. For the menu it would have been better to save the menu as an array instead of multiple strings. Some pages had reused functions, such as draw_buttons() and line_cursor(). Each page had separate functions for specific tasks such JSON_publish_menu(), save_order() and set_cal().*

*Overall the code structure is good and very maintainable for future updates.*

---

[Back to contents](#Contents)

### Social and Ethical Implications

We consider our project to have minimal social and ethical implications. To come to this conclusion, we assessed the following two broad questions:

#### *Data Security: Would our product involve the use of sensitive personal data, or constitute a potential security risk of unwanted data exposure for users involved, sensitive or otherwise?*

No. Our service uses the following data: consumer dietary preferences, and public restaurant info (name, menu etc). User dietary preferences are only stored locally on the device and are inaccessible to others on the service. We do not collect any user data for the purposes of analytics. While the use of a public mqtt broker is a major privacy issue, it was a requirement of the project.

#### *Ethical impact: Would our product be, intentionally or otherwise, prejudicing or discriminating, or cause harm towards, particular individuals or communities?*

No. Our product should be used equally by users from all communities. As most of the data processing is handled locally on the m5, there is minimal risk of other actors gaining access to such data for unwarranted purposes.

[Back to contents](#Contents)


## Project Evaluation:

<div align=center><img width="600" src="https://github.com/BarrettFrost/Smart_menu-project/blob/master/head_pic.png"/></div>


Our project successfully achieved its two goals. Firstly, we aimed to create a project that satisfied our user stories. Above that, we wanted our project to be robust and easily expanded further, i.e. to be condusive to smoothly segueing into further work and development (as we were only building a 'proof of concept' prototype at this stage).

Among considered directions for future work would be a persistent database for the web server. This would certainly be essential in a true final commercial build but was excluded in our project scope. Next, we would like the devices to able to report issues to one another. While not a core feature, this would be very useful for devices to be able to communicate when there are errors or disruptions, ranging from mild (like an restaurant menu being out of date) to severe (features breaking with a new update). Further, as mentioned in earlier sections, a built in help/tutorial tool, also not critical, would improve usability. Finally, additional UI/UX work could be done to make the product more visually appealing.

The most obvious feature to improve for the M5 would be increase the maximum menu items. Both saving menu as an array and implanting a scroll feature on listing pages would rectify this. The scroll feature could implement using the built-in gyroscopes on the M5. Another useful feature to implement would be to display the dietary requirements and max calories that have set in all pages so that user does not have to enter the preference branch to find out. Better error handling when the M5 has not received a JSON String. All pages have a use for each button except for my order page were only 2 buttons were used, it would have good to implement another feature. Obviously, this is a prototype in a commercial product with a touch screen interface it would be possible to have less of branch layout and some pages could be combined. Also, the menu could be incorporated into a better design like being incorporated into a table in a restaurant.*  

The group worked well to accomplish its goal despite numerous challenges. As covered in the previous section *design sprints*, we have demonstrated that we practiced AGILE development principles extensively. The principles emphasized a flexible, modular and minimalist design process, which prioritized breaking the project into small milestones to be accomplished incrementally. This was beneficial in many ways: our code was made more modular, as it was written and tested in small pieces, rather than as a big codeblock. This means that any future development would have a much easier time adding additional features, as it will not have to untangle dependencies. Distributing tasks between different team members was also easier with this process. One complication was that because our team are new programmers unfamiliar with working as a team, we were not practiced with writing code to a common standard. Hence, there were occasional frustrations merging code written by different authors. Our work has been compiled Git Hub repository. This project was, therefore, also a learning opportunity that taught us something that we might not have learned by working purely on solo projects. 

Communication through the quarantine period was managed with regular online meetings. The quarantine caused minimal disruption to the group's performance with regards to building the systems. This was because we were alreading working in a distributed workflow. However, it impacted our ability to conduct user testing. Specifically, while we were able to test subsystems independently, we were unable to do significant public testing, especially with the whole system in one location. This most likely had some impact on the final quality of the product, such as the UI/UX work being mediocre.

[Back to contents](#Contents)


