"use strict";

class Packet{
  conID=0;
  queryID=0;
  resList=[];
  listSize=0;
  restaurantSingle=null;

  //conID
  setConID(x){
    this.conID = x;
  }

  //queryID
  setQueryID(i){
    this.queryID = i;
  }
  getQueryID(){
    return this.queryID;
  }

  //restaurantSingleList
  getRestaurant(i){
    return this.resList[i];
  }
  addtoList(x){
    this.resList.push(x);
    this.listSize = this.resList.length;
  }
  removeFromList(i){
    this.resList.splice(i, 1);
    this.listSize = this.resList.length;
  }

  //listSize
  getListSize(){
    return this.listSize;
  }

  //restaurantSingle
  getRestaurant(){
    return this.restaurantSingle;
  }
  setRestaurant(x){
    this.restaurantSingle = x;
  }
}

class Restaurant{
  resID = "";
  resName = "";
  menu = [];
  menuSize = 0;

  //restaurantSingleID
  setResID(x){
    this.resID = x;
  }
  getResID(){
    return this.resID;
  }

  //restaurantSingleName
  setResName(x){
    this.resName = x;
  }
  getResName(){
    return this.resName;
  }

  //menu
  getFood(x){
    return this.menu[x];
  }
  addtoMenu(x){
    this.menu.push(x);
    this.menuSize = this.menu.length;
  }
  removeFromMenu(x){
    this.menu.splice(x,1);
    this.menuSize = this.menu.length;
  }

  //menuSize
  getMenuSize(){
    return this.menuSize;
  }
}

class Food{
  foodName = "";
  calories = 0;
  vegan = false;
  containsNuts = true;
  containsGluten = true;

  //foodName
  setFoodName(x){
    this.foodName = x;
  }
  getFoodName(){
    return this.foodName;
  }

  //calories
  setCalories(i){
    this.calories = i;
  }
  getCalories(){
    return this.calories;
  }

  //isVegan
  setVegan(x){
    this.vegan = x;
  }
  getVegan(){
    return this.vegan;
  }

  //containsNuts
  setContainsNuts(x){
    this.ContainsNuts = x;
  }
  getContainsNuts(){
    return this.ContainsNuts;
  }

  //containsGluten
  setContainsGluten(x){
    this.containsGluten = x;
  }
  getContainsGluten(){
    return this.containsGluten;
  }
}
