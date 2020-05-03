"use strict";

//restaurant table
var resTable = [];

function resTable_add(x){
  resTable.push(x);
}

function resTable_remove(x){
  resTable.splice(x,1);
}

//creating table
function createTable(){
  //Write headers of restaurant file
  var col = ["#","ID","Restaurant",""];

  var table = document.createElement("table");
  table.className='table table-striped table-bordered';
  //create table headers
  var tr = table.insertRow();
  tr.className='thead-dark';

  for(var i=0;i<col.length;i++){
    var th = document.createElement("th");
    th.innerHTML = col[i];
    tr.appendChild(th);
  }

  //fill restaurant data into table
  for(var i=0;i<resTable.length;i++){
    tr = table.insertRow();
    for(var j=0;j<col.length;j++){
      var tabCell = tr.insertCell();
      switch(j){
        case 0:
          tabCell.innerHTML = i+1;
          break;
        case 1:
          tabCell.innerHTML = resTable[i].resID;
          break;
        case 2:
          tabCell.innerHTML = resTable[i].resName;
          break;
        case 3:
          tabCell.innerHTML = "<button type='button' class='btn btn-light' onclick='createMenu(this)'>see menu</button>";
          break;
        default:
          tabCell.innerHTML = "NaN";
          break;
      }
    }
  }

  //load table into webpage
  var divContainer = document.getElementById("showrestaurants");
  divContainer.innerHTML = "";
  divContainer.appendChild(table);
  return true;
}

function createMenu(button){
  var res = resTable[(button.parentNode.parentNode.rowIndex)-1]
  var col = ["#", "Name", "Cal", "vegan", "Contains Nuts", "Contains Gluten"]

  var table = document.createElement("table");
  table.className='table table-striped table-bordered';
  //create table headers
  var tr = table.insertRow();
  tr.className='thead-dark';

  for(var i=0;i<col.length;i++){
    var th = document.createElement("th");
    th.innerHTML = col[i];
    tr.appendChild(th);
  }

  //fill menu data into table
  for(var i=0;i<res.getMenuSize();i++){
    tr = table.insertRow();
    for(var j=0;j<col.length;j++){
      var tabCell = tr.insertCell();
      switch(j){
        case 0:
          tabCell.innerHTML = i+1;
          break;
        case 1:
          tabCell.innerHTML = res.getFood(i).getFoodName();
          break;
        case 2:
          tabCell.innerHTML = res.getFood(i).getCalories();
          break;
        case 3:
          tabCell.innerHTML = res.getFood(i).getVegan();
          break;
        case 4:
          tabCell.innerHTML = res.getFood(i).getContainsNuts();
          break;
        case 5:
          tabCell.innerHTML = res.getFood(i).getContainsGluten();
          break;
        default:
          tabCell.innerHTML = "NaN";
          break;
      }
    }
  }

  //load table into webpage
  var divContainer = document.getElementById("showmenu");
  divContainer.innerHTML = "";
  divContainer.appendChild(table);
  return true;
}

//parsing incoming packet
function parse(packet){
  var p;

  switch(packet.queryID){
    //10: requesting list of restaurants
    case 10:
      p = listRes();
      p.setConID(packet.conID);
      send(p);
      break;
    //20: requesting specific resID
    case 20:
      p = getRes(packet.restaurantSingle.resID);
      p.setConID(packet.conID);
      send(p)
      break;
    //30: registering new restaurantSingle
    case 30:
      p = newRes(packet.restaurantSingle);
      p.setConID(packet.conID);
      send(p);
      break;
    case 40:
      p = updateRes(packet.restaurantSingle);
      p.setConID(packet.conID);
      send(p);
      break;
    default:
      console.log("parse: queryID %s was not recognized", packet.queryID);
      break;
  }
  createTable();
}

//query 10 (reply 11)
function listRes(){
  var p = new Packet();

  p.setQueryID(11);
  for(var i=0;i<resTable.length;i++){
    var res = new Restaurant();
    res.setResID(resTable[i].resID);
    res.setResName(resTable[i].resName)
    p.addtoList(res);
  }
  return p;
}

//query 20 (reply 21)
function getRes(id){
  var p = new Packet();
  var found = false;
  for(var i=0;i<resTable.length;i++){
    if(!found){
      if(!(resTable[i].resID).localeCompare(id)){
        p.setQueryID(21);
        p.setRestaurant(resTable[i]);
        found = true;
        return p;
      }
    }
  }
}

//query 30 (reply 31)
function newRes(res){
  var p = new Packet();
  var r = new Restaurant();

  p.setQueryID(31);
  r.setResID(makeID(4));
  r.setResName(res.resName);
  for(var i=0;i<res.menu.length;i++){
    var f = new Food();
    f.setFoodName(res.menu[i].foodName);
    f.setCalories(res.menu[i].calories);
    f.setVegan(res.menu[i].vegan);
    f.setContainsNuts(res.menu[i].containsNuts);
    f.setContainsGluten(res.menu[i].containsGluten);
    r.addtoMenu(f);
  }
  p.setRestaurant(r);
  resTable_add(r);
  return p;
}

//query 40 (reply 41)
function updateRes(res){
  var p = new Packet();
  var found = false;
  for(var i=0;i<resTable.length;i++){
    if(!found){
      if(!(resTable[i].resID).localeCompare(res.resID)){
        p.setQueryID(41);
        resTable[i].setResName(res.resName);
        for(var j=0;j<resTable[i].getMenuSize();j++){
          resTable[i].removeFromMenu(j);
        }
        for(var j=0;j<res.menu.length;j++){
          var f = new Food();
          f.setFoodName(res.menu[j].foodName);
          f.setCalories(res.menu[j].calories);
          f.setVegan(res.menu[j].vegan);
          f.setContainsNuts(res.menu[j].containsNuts);
          f.setContainsGluten(res.menu[j].containsGluten);
          resTable[i].addtoMenu(f);
        }
        found = true;
        return p;
      }
    }
  }
}

////temporary main
function main(){
  if(!createTable(resTable)){
    document.getElementById("showrestaurants").innerHTML = "Error when creating table!";
  }
}

//test function
function test(){
  //send(testObj3);
  //send(testObj4);
  //send(testObj1);
  return;
}
