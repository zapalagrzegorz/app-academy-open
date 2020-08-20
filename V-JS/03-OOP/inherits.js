function MovingObject() {
  this.name = 'moving object';
}

MovingObject.prototype.moves = function () {
  console.log('moves');
};

MovingObject.prototype.tellName = function () {
  console.log(`name: ${this.name}`);
};

// Define a Surrogate class
// Set the prototype of the Surrogate (Surrogate.prototype = SuperClass.prototype)
// Set Subclass.prototype = new Surrogate()
// Set Subclass.prototype.constructor = Subclass
// Function.prototype.inherits = function (SuperClass) {
//   // this to class
//   //
//   function Surrogate() {}
//   Surrogate.prototype = SuperClass.prototype;
//   this.prototype = new Surrogate();
//   // this.prototype = Object.create(SuperClass.prototype);
//   this.prototype.constructor = this;
// };
Function.prototype.inherits = function (BaseClass) {
  function Surrogate () {}
  Surrogate.prototype = BaseClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};

function Ship() {
  MovingObject.call(this);
}

Ship.inherits(MovingObject);

Ship.prototype.specificMoves = function () {
  console.log('ship moves');
};

Ship.prototype.fire = function () {
  console.log('ship fires');
};

function Asteroid() {}
Asteroid.inherits(MovingObject);

Asteroid.prototype.specificMoves = function () {
  console.log('asteroid moves');
};

Asteroid.prototype.blast = function () {
  console.log('asteroid blasts');
};


const ship = new Ship();
const asteroid = new Asteroid();

ship.moves();
asteroid.moves();

asteroid.blast();
ship.fire();

ship.specificMoves();
asteroid.specificMoves();

ship.tellName();

console.log(ship instanceof Ship);
console.log(asteroid instanceof Asteroid);
console.log(ship instanceof MovingObject);
console.log(asteroid instanceof MovingObject);