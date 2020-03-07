//Template for CLASSES and JSON serial/deserializer.

//JSONClass contains the classes & methods for our JSON data. Each lead should
//convert it to their respective languages/systems. Follow the structure as much as possible 
//to maintain uniformity (if any big changes are to be done, keep everyone informed)

//JSONtest shows the functionality of the template. AFAIK its all working.

//loadJSON and saveJSON, as the name suggests, loads and saves a 'packet' to a json file. The 
//the default json file name is 'JSONpacket.json'

//loadJSON returns the JSON packet. So implementation is simple! e.g. 'packet data = loadJSON()'.

//**IMPORTANT Final Note!!!**: You will notice that the JSON file loads the variables out of order.
//This is expected according to google (because JSON stringify doesnt follow an index)

void setup(){
  JSONtest();
  println("Test Completed!");
  exit();
}
