// Write your own myBind(context) method. Add it to Function.prototype. You'll want to:
// Return an arrow function.
// The arrow function captures this and context.
// In the anonymous function, call Function.prototype.apply on this, passing the context.

// Assume the method you're binding doesn't take any arguments; we'll see tomorrow how to use the rest and spread operators to fix this.
// How would you test your "bind" method out? Try out this example code:

// turnOn.myBind(lamp);
Function.prototype.myBind = function (context) {
  // context to lamp
  // this'em jest obiekt wywołujący - czyli funkcja turnOn
  return () => {
    this.apply(context);
  };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function () {
  console.log("Turning on " + this.name);
};

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"
