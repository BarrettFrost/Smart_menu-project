"use strict";

//mqtt client
var client;

//broker information
var host = "broker.mqttdashboard.com";
var port = 8000;
var subscription = "Smart_menu";

//client id
var clientID = "webapp1"

//test message(to be removed)
var testMessage = {"Hello": "Bye"};

//connecting to MQTT server
function init(){
  console.log("connecting to " + host + " at port " + port);
  client = new Paho.MQTT.Client(host,port,clientID + makeID(4));

  //callback handlers
  client.onConnectionLost = lostConnection;
  client.onMessageArrived = handle;

  var options = {
    timeout: 3,
    onSuccess: onConnect,
    onFailure: onFailure,
  };
  client.connect(options);
}

//connection success
function onConnect(){
  console.log('Connection Established');
  alert('Connection Established');
  client.subscribe(subscription);
  //test function
  test();
}

//connection fail
function onFailure(){
  console.log('Connection failed');
  alert('Connection Failed');
}

//connection lost
function lostConnection(responseObject){
  if(responseObject.errorCode != 0){
    console.log("Connection Lost: " + responseObject.errorMessage);
  }
}

//sending packet
function send(packet){
  try{
    var mqtt = new Paho.MQTT.Message(JSON.stringify(packet));
    mqtt.destinationName = subscription;
    client.send(mqtt);
  }catch(e){
    console.log("send:" + e);
    console.log("packet was: " + packet);
  }
}

//handle incoming packets
function handle(received){
  try{
    var data = JSON.parse(received.payloadString);
    parse(data);
    console.log(data);
  }catch(e){
    console.log("handle:" + e);
    console.log("packet received was: " + received.payloadString);
  }
}

//random alphanumeric generator
function makeID(len){
   var id = '';
   var characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
   for ( var i = 0; i < len; i++ ) {
      id += characters.charAt(Math.floor(Math.random() * characters.length));
   }
   return id;
}
