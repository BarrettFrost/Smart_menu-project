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

2. System Implementation [1000 words]:
  a. Breakdown of project into sprints (showing the users stories implemented in each).

Work on the project started with the consumer sub-service on the m5 stack. We did so because the website and desktop applications operated in the background for the consumer user. Thus, we judged that it was sufficient to simulate their functionality at this early stage for concept testing. Once we settled on the idea of our project, we first attempted the define the minimum features the m5 program should possess in order to fulfill the intended use of the sub-service. We agreed on two points and worked from there: a preference page to set/save dietary needs, and a menu browser that cross-referenced the saved preferences.

The following video was captured during our first feedback test (with a paper prototype):

Input collected during the test was considered for the next stage of our design cycle: a basic form of the m5 application. We also further fleshed out the app, adding more pages e.g. as a restaurant browser, and planning how the buttons on the m5 would be used.

[b]User Story[/b]: One major change was that an extraneous feature in the initial design was dropped:
We initially envisioned participating restaurants to implement some form of unique identifier on their dish (a QR code or colored plate e.g. a sushi bar), to be scanned by restaurant patrons when ordering. Feedback we received from test users suggested that this system was unintuitive to handle, and simply unnecessary in lieu of a simple checkbox system built into the m5's menu browser function.

[Evidence of the v1 version of the app]

For the next major cycle, we moved to planning the mqtt packet, i.e. the JSON data structure we would use, and the pipeline of all three subsystems in preparation for the implementation of networking(at this point, the m5 stack was still relying on dummy functions). 

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
