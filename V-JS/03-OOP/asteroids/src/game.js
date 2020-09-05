// Write a Game class in src/game.js.
//  Define the following constants on the Game class: DIM_X, DIM_Y, and NUM_ASTEROIDS.
import './asteroid';
import Asteroid from './asteroid';
import Ship from './ship';
import Bullet from './bullet';

function Game() {
  this.asteroids = [];
  this.bullets = [];
  this.ship = new Ship({ pos: Game.prototype.randomPosition(), game: this });
  // console.log(this.ship);
}

Game.DIM_X = window.innerWidth * 0.8;
Game.DIM_Y = window.innerHeight * 0.8;
Game.NUM_ASTEROIDS = 6;

// Game.prototype.add(obj) method that added to this.asteroids/this.bullets if obj instanceof Asteroid/obj instanceof Bullet. I wrote a similar Game.prototype.remove(obj) method. This was easier than having two methods each for Asteroid and Bullet.

Game.prototype.add = function (object) {
  if (object instanceof Asteroid) {
    this.asteroids.push(object);
  }
  if (object instanceof Bullet) {
    this.bullets.push(object);
  }
};

Game.prototype.addAsteroids = function () {
  for (let i = Game.NUM_ASTEROIDS; i > 0; i--) {
    const config = { pos: Game.prototype.randomPosition(), game: this };
    this.asteroids.push(new Asteroid(config));
  }
};

Game.prototype.allObjects = function () {
  return [...this.asteroids, ...this.bullets, this.ship];
};

// Randomly place the asteroids within the dimensions of the game grid.
Game.prototype.randomPosition = function () {
  return [Game.DIM_X * Math.random(), Game.DIM_Y * Math.random()];
};

//  method. It should call clearRect on the ctx to wipe down the entire space. Call the draw method on each of the asteroids.

Game.prototype.draw = function (ctx) {
  ctx.fillStyle = 'black';
  ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);

  this.allObjects().forEach((object) => {
    object.draw(ctx);
  });
};

// Write a Game.prototype.moveObjects method. It should call move on each of the asteroids.
Game.prototype.moveObjects = function () {
  this.allObjects().forEach((movingObject) => {
    movingObject.move();
  });
};

Game.prototype.wrap = function (pos) {
  const wrappedPos = [...pos];
  if (pos[0] > Game.DIM_X) {
    wrappedPos[0] = 0;
  }
  if (pos[0] < 0) {
    wrappedPos[0] = Game.DIM_X;
  }
  if (pos[1] > Game.DIM_Y) {
    wrappedPos[1] = 0;
  }
  if (pos[1] < 0) {
    wrappedPos[1] = Game.DIM_Y;
  }
  return wrappedPos;
};

Game.prototype.checkCollisions = function () {
  this.allObjects().forEach((object) => {
    this.allObjects().forEach((otherObject) => {
      if (object !== otherObject && object.isCollidedWith(otherObject)) {
        // wszystkie obiekty mają tę metodę przez definicję w parencie
        // definicja ta może być pusta
        // można też ją nadpisać w normalnym obiekcie
        object.collideWith(otherObject);
      }
    });
  });
};

Game.prototype.step = function () {
  this.moveObjects();
  this.checkCollisions();
};

Game.prototype.remove = function (object) {
  if (object instanceof Asteroid) {
    this.asteroids = this.asteroids.filter((memoryAsteroid) => {
      return object != memoryAsteroid;
    });
  }

  if (object instanceof Bullet) {
    this.bullets = this.bullets.filter((otherBullet) => {
      return object != otherBullet;
    });
  }
};

Game.prototype.isOutOfBounds = function(object){
  
  // góra gdy pos Y < 0,
  if(object.pos[0] < 0) return true;
  if(object.pos[1] < 0) return true;
  if(object.pos[0] + 2*object.radius > Game.DIM_X) return true;
  if(object.pos[1] + 2*object.radius > Game.DIM_Y) return true;
  // lewo gdy pos X < 0;
  // prawo gdy pos X + 2*radius > length
  // dół gdy pos Y + 2*radius > height
};

export default Game;
