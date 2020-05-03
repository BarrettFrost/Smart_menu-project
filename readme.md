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

M5 Object oriented design
The smart menu design featured the List and menu classes. Since the menu must be able to display, select and flag an unknown number of restaurant names or menu items, object-oriented design seemed to most appropriate approach.  The code had an array of list and menu once the items have been received via JSON. The classes allow variables associated with each menu item e.g. the name. These variables could then be manipulated for instance selecting an item and using method to change the selection integer or changing the flag depending on Booleans for dietary requirements. 

M5 Data persistence 
The ardiuno-esp32 Preferences library allowed us to save the contents to flash memory on the M5 stack for permanent storage. This was necessary for the M5 stack to save the user dietary requirements, maximum calories per meal and the contents of the order they want to place. The preferences library had partitioning for the variables and each variable could be assessed using a key. The dietary requirements were saved as integers with 0(false) and 1(true). The max calories were saved as integer as well and the menu items and restaurant name were saved as a string.

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
