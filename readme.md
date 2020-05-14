Smart_Menu
===

////Preliminary Draft


Smart_Menu is an Internet of Things (IoT) solution that matches your dietary needs directly with what's on the menu ! Combining a menu browser (common in food finding apps, e.g Yelp) with a diet planner (e.g. [insert app here]), Smart_Menu makes planning your next meal safer and more convenient than ever before.

1.System Design [1000 words]:
----

a. Architecture: *Insert flow diagram*

User story: The system will be used initiated by a customer using the IOT device to order a meal from a restaurant. Before doing so, They would have first set their dietary preferences: restrictions and desired calories per meal. The customer would query the Web Application for a list of restaurants from the company running the system. They would then select the restaurant they want to order food from and send that information to the company. Then the company would ask the restaurant owner for the menu. After the company would relay this menu to the customer which they would choose their meal and save their order.


```
b. Object-Oriented design of key sub-systems

```

All of our sub-systems were built around principles of object-oriented design. The reasons for this were obvious to us: we would be working predominantly with abstract data types, and handling multiple instances of the same objects, ('restaurants' and 'food'). Standardizing on OOP would also allow us to homogenize across all the subsystems, keeping things simple to understand and easy to debug.

Excepts from our m5 and Desktop application design, that were most driven my these principles, are as follows:



*M5*


The smart menu design featured the List and menu classes. Since the menu must be able to display, select and flag an unknown number of restaurant names or menu items, object-oriented design seemed to most appropriate approach.  The code had an array of list and menu once the items have been received via JSON. The classes allow variables to be associated with each menu item e.g. the name. These variables could then be manipulated, for instance selecting an item and using method to change the selection integer or changing the flag depending on Booleans for dietary requirements.



*DESKTOP*


The processing part of this project was developed based on Object-Oriented design. This model is for a restaurent which could connect with web - sending its restaurant name, get its restaurant id and then send its menu items. Although Object-oriented programming is not required for Processing, However, object-oriented design can make Processing program has more reasonable architecture and easier to maintain and extend.
In Object-Oriented design, A complicate system consists of one or more classes. One class encapsulates the state of the object and provides the behavior (class functions) to others. Such methods to solve problems are more close to daily life and natural way of thinking which helps to improve the efficiency and quality of software development. Due to the existence of inheritance, even If the requirements are changed, the maintenance is only in the local module, so it is very convenient to maintain and expand the existing features. Finally, In a group job, each member focus on their own classes which enables the project to be of high quality.




So there are at least three main object:

*Class* Restaurant - which contains (String) restaurant_name, (String) restaurant_id;

*Class* Food - which contains (String) food_name, (int) food_calories,  (boolean) if_vegetarian, (boolean) ifcontain_gluten,    (boolean) ifcontain_nuts;

*Class* Menu - which contains an arraylist, Food[] foods.

These functions make the system of a restaurant_menu:

  - adding some new food [add_item(), doAdd() function]: pass name, calories,  vegetarian, gluten, nuts as parameters and create a new food object;
  - editing existing food [edit_item(), doUpdata() function]: just create a new food object like add_item, and then do some update, to send new items as json package;
  - deleting existing food [delete(), doDelete() function]: we use menu object, and delete the selected index;
  - doing registration [registration(), doRegister() function]: send menu item in the format of json Package.

Requirements for key sub-systems

An overview of the key requirements of our sub-systems (desktop, web, m5 Stack) were decided as follows:

  a. The Desktop Application represents the restaurants' end. It would need to be able to register with the service, and be able to upload/update their data, e.g. name and menu, on the database.

  b. The Web Application represents the developer/service provider end. It would need to handle restaurant registration and the service's database.

  c. The Arduino/m5 Stack represents the consumer end. It has two primary feature. The first is allowing users to configure their dietary preferences. Next is recording an order. the M5 accesses and browses restaurant menus saved on the web application. The user's configured preferences should be read as the order is made, e.g. by flagging dishes that exceed their intended calorie intake, or contain unsafe ingredients.

(d. The evolution of UI wireframes for key sub-systems)

*DESKTOP*
- EDITION 1.0: have 2 pages for desktop app
    - A restaurant menu page: show the items of menu, and for registration
    - A registration page: the users can input restaurant name and choose 'register' and 'cancel'
    ![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/desktop_videos/version%202.png)
    
- EDITION 2.0: have 2 pages, which including a restaurant menu page, a registration page
    - A restaurant menu page: show the items of menu, and the user can select the specific items of this menu, which helps user to delete. Another function in this page is to register.
    - A registration page
    ![Image](https://github.com/BarrettFrost/Smart_menu-project/blob/master/desktop_videos/version%203.png)
    
- EDITION 3.0: have 3 pages, which including a restaurant menu page, a registration page and a add/edit page
    - A restaurant menu page: the user can select the specific items not only for deleting items, but also for edit items. Totally there are 4 functions in this page: ADD, EDIT, DELETE, REGISTER_NEW (means the regiatration for a new restaurant)
    - A add/edit page: the user could add the information of particular food item into the menu, which includs the name of food, food calories, and set if this food contains meat, nuts and gluten...the user could also edit those information in a page that has the memory of privious food information
    - A registration page
    

*M5*

![M5 UI](https://github.com/BarrettFrost/Smart_menu-project/blob/master/M5%20pictures%20graph/UI.PNG)

Due to the limited buttons we had to divide access to pages between 3 separate branches as seen from the diagrams above. There is a consistent layout for all pages to make the user experience more intuitive. This layout consisted of a title at the top and below displayed whatever functions the page served. At the bottom there are buttons squares with names attached describing the certain function of the button, whether it be moving to another page or saving an order. The buttons on screen were designed to line up with the buttons on the physical device so that the user knew which button did what. For the flagging of menu items red circles was chosen to be used. The M5 stack provides several ways to do this but it needs to be non-obtrusive and striking. The red colour draws the user’s attention and the small circle does not take up too much space.

*Web Application*

- Started with a basic html table displaying registered restaurant data.
- Basic Bootstrap implementation, e.g. responsive table, to improve user experience.
- Added menu browser.
- Further visual improvements through Bootstrap.


Communication protocols  

(e. Details of the communication protocols in use)

Our communication protocol is simple, relying on two variables, queryID and conID, stored in our JSON packet to distinguish packets. queryID is a two digit integer sequence that identifies the type of query. The first digit in the sequence denotes the query type, while the second digit, either '0' or '1', denotes when the packet is a query or a reply ('0' = query, '1' = reply). All used sequences are labelled below:

//10: M5 requesting restaurant list from web application. Reply: 11
//20: M5 requesting menu from selected restaurant. Reply: 21
//30: Desktop app (restaurant) registering with the web server. Reply: 31
//40: Desktop app (restaurant) updating information with the web server. Reply: 41

conID serves to identify unique conversations between devices. This ensure that replies are received and read properly.

(f. Details of the data persistence mechanisms in use)

*M5*

 The ardiuno-esp32 Preferences library allowed us to save the contents to flash memory on the M5 stack for permanent storage. This was necessary for the M5 stack to save the user dietary requirements, maximum calories per meal and the contents of the order they want to place. The preferences library had partitioning for the variables and each variable could be assessed using a key. The dietary requirements were saved as integers with 0(false) and 1(true). The max calories were saved as integer as well and the menu items and restaurant name were saved as a string.

*DESKTOP Data persistence*

 - We have the need of persist data about menu and single restaurant in the daily life.
 - We use json file (menu.json, restaurant.json) as API instead of real database.
 - In processing desktop, we use functions such as loadMenu() and loadReataurant() to load the json file, and to use this database.
 - When the user add/edit/delete the food, or register a new restaurant, the data would be changed in the saved json file!

 Web Technologies in use

 The website is built with the three standard languages: HTML, CSS and Javascript. They were chosen because of the extensive support material available (online tutorials through Youtube, w3schools, geeksforgeeks, etc.). Choosing a well supported language set helped speed up the learning process, leading to a shorter development time. It was also good practice to work with industry standard languages and built familiarity for future projects.

 The primary browser used throughout development was Google Chrome, due to its ubiquity and light weight. The built in DevTools were also very helpful for debugging, especially for Javascript as an interpreted language. However, we also tested our site to work with Firefox.

 Our framework of choice was Bootstrap. With Bootstrap, it was extremely easy to quickly implement useful UI features. The three main features of Bootstrap that were used was styling, containers and improved tables. First, working with and modifying Bootstrap's styling made the process of setting and changing fonts and colors much quicker than if we were to build our own stylesheet from scratch. Next, Bootstrap's containers were particular helpful at building a responsive layout that could wrap our page's elements to any screen size (prior to implementing Bootstrap's layout features, we had a lot of problems with text clipping given that our web page is dominated by two large tables). Finally, Bootstrap's tables tags allowed us to easily make our tables visually appealing and responsive.

 Finally, we used the mqtt plugin by paho to implement mqtt functionality into our site.

2.System Implementation [1000 words]:
----
  a. Breakdown of project into sprints (showing the users stories implemented in each).

Ideation (late Jan - early Feb)
Our project began at the ideation step. During initial brainstorming, once we'd decided that our project would be dietary related, We settled on two user stories to define our goals.

1.) [the m5 user] wants to be more calorie conscious when ordering meals to ensure I do not overeat.
1.) [the m5 user] wants to easily tell what ingredients are in each dish, to avoid dietary allergies.

Based on these goals, we decided that combining a diet tracking function and a dish ingredients filter would achieve these goals. We initially envisioned a system that paired a camera on the user's smartphone, with restaurants tagging their dishes with unique identifiers to be scanned (conceptually, a QR code, or colored plate e.g. a sushi bar). This is shown our captured paper prototype:

We quickly scrapped this idea after receiving negative feedback during user testing. Our participants found this setup unintuitive and too much hassle than it was worth. We also questioned the burden of implementation for restaurants to be far too high. After discussion, we decided that a menu browser, where restaurants simply uploaded their menus to a central database to be parsed in the app, was much simpler to build and use, while still achieving our objectives.

Sprint 1: the M5 (Feb)

Next, we built the M5 application. As this was simply a continuation of our objectives at the ideation step (we were simply building our paper prototype), our guiding user stories remained the same. Users found the new format much more user friendly. Regardless, we concluded that the app would benefit from a built in 'help' or 'tutorial' section (discussed in future work).

Sprint 2: Web Application, MQTT testing(Late Feb - Early March)

With a working M5 program, we next moved to build the web application, and experiment with sending JSON packets through MQTT. Our user stories at this stage were:

1) [the m5 user] wants to easily browse restaurants to find what to eat.

From these, we decided that the web app's primary feature would be hosting a database of restaurants on the service, to be queried by the m5. This was achieved with dummy templates at first. Correspondingly, we also added an extra page on the m5 to browse a restaurant list, in preparation to receive and display data from the web app (the early form of the m5 program only showed a single dummy restaurant).

We also began experimenting with MQTT at this step. At the end of this sprint, both the m5 and web app were capable of sending dummy text to the mqtt broker.

Sprint 3: JSON packet, MQTT (March)

A continuation of sprint 2, this sprint's big goal was replacing all the dummy data with proper networking code. We finalized the structure of our JSON packet, and completed proper mqtt implementation between the M5 and the Web app.

Sprint 4: functionality testing, Desktop application

Two goals were achieved for our fourth sprint. Firstly, we began debugging/cosmetic work on the m5 and Web App. Bootstrap was added to our web app at this stage.

Secondly, we began to work on the Desktop application, meant to represent the restaurant. However, we kept the following user story in mind:

1) [the restaurant user] wants to easily edit their data, so using the service will not be a hassle.

Accordingly, we decided that besides registration, the restaurant app also needed user friendly pages to easily edit its basic info and menu(covered in above sections).

Sprint 5: Full project testing (Late March - April)

This (final) sprint roughly encapsulated our several weeks of final testing, debugging and polishing. Notable changes made during this stage was adding the 'conID' variable. We met once a week to test core functionality to ensure that we had not broken anything following polish work.

How we evaluated our designs
We primarily relied on a pass/fail technique when evaluating our design. this meant that we would determine beforehand the intended design objectives at the start of each stage/sprint, and follow up with an evaluation of whether those objectives were met at the end of the sprint period (most often coinciding with our meeting schedule). Tasks would be broken down to as many constituent parts and steps as possible for clarity. For example, even a simple feature like 'to read an mqtt packet' would be broken down into:

//Sprint goals
- 1) Can the app save JSON packets to file? Y/N
- 2) Can the app load JSON packets from file? Y/N
- 3) Can the app receive an mqtt message? Y/N
- 4) Can the app parse the mqtt message as a JSON file? Y/N

...and so on.

We favored this technique for many reasons. Firstly, it kept us focused on achieving our core requirements. Secondly, it made it easy for all members on the team to communicate and understand the stages of development for each subsystem despite the distribution of work. Finally, it ensured that we abided by the agile design principle of 'just good enough', and did not waste manpower on unneccesary feature bloat.

Some notable limitations was a lack of attention paid to user comfort. Our binary pass/fail system was poorly suited to assess more nuanced features like user comfort and interface. Another limitation was the lack of emphasis on external input. By sticking rigidly to our sprint checklists, rather than more openly assessing quality, the opportunity to receive general feedback was also limited.

Overall, considering that our goal was to design a prototype, we accept the compromise that our evaluation technique brought. It greatly lubricated our workflow, minimizing the impact of the quarantine on our project. Working to rigid requirements also kept our development process lightweight and quick, rather than being bogged down with obsessing to work to arbitrary standards. However, we acknowledged that it led to an underprioritization of less 'technical' features, like visual work. In retrospect, It would have likely been possible to transition from a binary to a scaled detailed assessment criteria, e.g. a evaluation matrix, towards the final stages of the project once the core requirements had been satisfied.

Social and Ethical Implications of the work

We consider our project to have minimal social and ethical implications. To come to this conclusion, we assessed the following two broad questions:

Q1 (Data Security) - Would our product involve the use of sensitive personal data, or constitute a potential security risk of unwanted data exposure for users involved, sensitive or otherwise?

No. Our service uses the following data: consumer dietary preferences, and public restaurant info (name, menu etc). User dietary preferences are only stored locally on the device and are inaccessible to others on the service. We do not collect any user data for the purposes of analytics. While the use of a public mqtt broker is a major privacy issue, it was a requirement of the project.

Q2 (Ethical impact) - Would our product be, intentionally or otherwise, prejudicing or discriminating, or cause harm towards, particular individuals or communities?

No. Our product should be used equally by users from all communities. As most of the data processing is handled locally on the m5, there is minimal risk of other actors gaining access to such data for unwarranted purposes.




3.Project Evaluation [800 words]:
---




```
Our project successfully achieved its two goals. Firstly, we aimed to create a project that satisfied our user stories. Above that, we wanted our project to be robust and easily expanded further, i.e. to be condusive to smoothly segueing into further work and development (as we were only building a 'proof of concept' prototype at this stage).

Among considered directions for future work would be a persistent database for the web server. This would certainly be essential in a true final commercial build but was excluded in our project scope. Next, we would like the devices to able to report issues to one another. While not a core feature, this would be very useful for devices to be able to communicate when there're errors or disruptions, ranging from mild (like an restaurant menu being out of date) to severe (features breaking with a new update). Further, as mentioned in earlier sections, a built in help/tutorial tool, also not critical, would improve usability. Finally, additional UI/UX work could be done to make the product more visually appealing.

The group worked well to accomplish its goal despite numerous challenges. Our design sprints demonstrate that we practiced AGILE design principles, including working and testing in stages and focusing on a minimalism. Communication through the quarantine period was managed with regular online meetings. Overall, we believe that there was the quarantine caused minimal disruption to the group's ability to work. However, it impacted our ability to conduct user testing. Specifically, while we were able to test subsystems independently, we were unable to bring all the separate subsystems together in a public venue for a full test.

```

Evaluation M5

All the main functions of the M5 were successfully implemented and during the testing of the system the M5 performed as intended. Since the M5 was the system that had to initialise the networking. When buttons were pressed, they had to produce and send a JSON String to the server. Once the response is received then the M5 would move onto the next page. This response was very rapid during testing worked without flaw. Though an issue may arise if the M5 does not receive a response back from the MQTT as the M5 does not notify the user when this has occurred. Whereas during the initial setup of the M5 there is message displaying connecting which will notify the user when M5 cannot connect to the WI-FI. One of the M5 issues was it is not suited to be a menu due to the size of the screen. We had to use the smallest text size to fit as much menu items in the screen as possible. But this may cause difficulty in reading for some users and there had to be a limit on the number of menu items. Another UI issue was the cursor had to be made from a line which once again might be difficult to see.  Though overall the UI for the M5 is intuitive for the user due to the consistent layout (write about the layout in UI wireframe). The saving to permanent memory was successful for dietary requirement and max calories, for the menu it would have been better to save the menu as an array instead of multiple strings. For the structure of the code a switch was used to access each page, each of these had functions to display the UI. Some pages had reused functions such as draw_buttons() and line_cursor(). Of course each page had separate functions for specific tasks such JSON_publish_menu(), save_order() and set_cal().  So overall the code structure makes the system very maintainable for future updates.

Evaluation DESKTOP

The Processing client is mainly divided into three parts: View, Model and Events.
Each module is responsible for relatively independent functions. 
	The View module is responsible for creating the GUI user interface. The View class can create the interface of registration, main interface, add and modify according to different parameters. The Model part is responsible for data saving and loading. The Food class represents a Menu item, while the Menu class represents the entire Menu and contains multiple food. Events module responsible for handling the events of the interface. For example, When a button (such as register button) is clicked, the corresponding Json packet is sent to server and the Json data from the server is processed. Based on this design, the whole client has a reasonable architecture and is easy to maintain and expand. The weak point of this program is that the data format between client and server is not concise enough, and there exists some redundant data items.


Future work

The most obvious feature to improve for the M5 would be increase the maximum menu items. Both saving menu as an array and implanting a scroll feature on listing pages would rectify this. The scroll feature could implement using the built-in gyroscopes on the M5. Another useful feature to implement would be to display the dietary requirements and max calories that have set in all pages so that user does not have to enter the preference branch to find out. Better error handling when the M5 has not received a JSON String. All pages have a use for each button except for my order page were only 2 buttons were used, it would have good to implement another feature. Obviously, this is a prototype in a commercial product with a touch screen interface it would be possible to have less of branch layout and some pages could be combined. Also, the menu could be incorporated into a better design like being incorporated into a table in a restaurant.  

As for the desktop app, we can further improve the function of the program and optimize the architecture of the program. For example, design a more concise JSON data format for the communication between the client and the server. Also, we could improve the user interface to make the user experience more friendly. Before submit the data user input to system API, we could do more verification job. For example, the name of food should has a maximum length and only contains alphanumeric characters and the value of calories should stay in a reasonable range.




////Unedited Assignment Brief

1. System Design [40pts]:
  a. Architecture of the entire system
  b. Object-Oriented design of key sub-systems (e.g. Desktop Application, Web
    Application etc.)
  c. Requirements of key sub-systems (in the form of selected user stories)
  d. The evolution of UI wireframes for key sub-systems
  e. Details of the communication protocols in use (including a rational fo'['r your choice)
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
