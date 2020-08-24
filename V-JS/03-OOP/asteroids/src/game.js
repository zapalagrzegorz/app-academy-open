// Write a Game class in src/game.js.
//  Define the following constants on the Game class: DIM_X, DIM_Y, and NUM_ASTEROIDS.
import './asteroid';
import Asteroid from './asteroid';

function Game() {
  this.asteroids = [];
}

Game.DIM_X = window.innerWidth * 0.8;
Game.DIM_Y = window.innerHeight * 0.8;
Game.NUM_ASTEROIDS = 10;

Game.prototype.addAsteroids = function () {
  for (let i = Game.NUM_ASTEROIDS; i > 0; i--) {
    const config = { pos: Game.prototype.randomPosition() };
    this.asteroids.push(new Asteroid(config));
  }
};

// Randomly place the asteroids within the dimensions of the game grid.
Game.prototype.randomPosition = function () {
  return [Game.DIM_X * Math.random(), Game.DIM_Y * Math.random()];
};

//  method. It should call clearRect on the ctx to wipe down the entire space. Call the draw method on each of the asteroids.

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  this.asteroids.forEach((asteroid) => {
    asteroid.draw(ctx);
  });
};

// Write a Game.prototype.moveObjects method. It should call move on each of the asteroids.
Game.prototype.moveObjects = function () {
  this.asteroids.forEach((asteroid) => {
    asteroid.move();
  });
};

export default Game;
