// Write a function titleize that takes an array of names and a function (callback). titleize should use Array.prototype.map to create a new array full of titleized versions of each name - titleize meaning "Roger" should be made to read "Mx. Roger Jingleheimer Schmidt". Then pass this new array of names to the callback, which should use Array.prototype.forEach to print out each titleized name.

const printCallback = (element) => console.log(element);

const titleize = (arr, cb) => {
  const titleized = arr.map((element) => `Mx. ${element} Jingleheimer Schmidt`);
  titleized.forEach(cb);
};

// titleize(["Mary", "Brian", "Leo"], printCallback);

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function () {
  console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
};

Elephant.prototype.grow = function () {
  return console.log(`${this.name} is now ${(this.height += 12)}`);
};

Elephant.prototype.addTrick = function (trick) {
  return this.tricks.push(trick);
};

Elephant.prototype.play = function () {
  const trick = this.tricks[Math.floor(Math.random() * this.tricks.length)];
  console.log(`${this.name} is ${trick}`);
};

const elephant = new Elephant("Grisha", 10, [
  "swimming",
  "watching TV",
  "play football games",
]);

// elephant.trumpet();
// elephant.grow();
// elephant.addTrick("running");
// elephant.play();

let ellie = new Elephant("Ellie", 185, [
  "giving human friends a ride",
  "playing hide and seek",
]);
let charlie = new Elephant("Charlie", 200, [
  "painting pictures",
  "spraying water for a slip and slide",
]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, [
  "trotting",
  "playing tic tac toe",
  "doing elephant ballet",
]);

let herd = [ellie, charlie, kate, micah];

const paradeHelper = (elephant) => console.log(`${elephant.name} is trotting`);

// herd.forEach(paradeHelper);
/**
 * Closure
 * private vars
 */

// const dinerBreakfast = () => {
//   const order = ["cheesy scrambled eggs"];
//   return function (newOrder) {
//     order.push(newOrder);

//     console.log(`I'd like ${order.join(" and ")} please`);
//   };
// };

// function dinerBreakfast() {
//   let order = "I'd like cheesy scrambled eggs please.";
//   console.log(order);

//   return function (food) {
//     order = `${order.slice(0, order.length - 8)} and ${food} please.`;
//     console.log(order);
//   };
// }

let bfastOrder = dinerBreakfast();

bfastOrder("chocolate chip pancakes");
bfastOrder("grits");
