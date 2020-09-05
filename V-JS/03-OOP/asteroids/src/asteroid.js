import Util from './utils';
import MovingObject from './moving_object';
import Ship from './ship';
import Bullet from './bullet';

function Asteroid(options) {
  options.color = Asteroid.COLOR;
  options.radius = Asteroid.RADIUS;
  MovingObject.call(this, options);
  this.vel = Util.randomVec(5);
}

// Asteroid.prototype.collideWith(otherObject): if otherObject instanceof Ship, call Ship.prototype.relocate. The Ship.prototype.relocate method should reset the Ship's position to game.randomPosition() and reset velocity to the zero vector.

Util.inherits(Asteroid, MovingObject);
// Pick a default COLOR and RADIUS for Asteroids.
// Set these as properties of the Asteroid class: Asteroid.COLOR and Asteroid.RADIUS
Asteroid.COLOR = 'darkgrey';
Asteroid.RADIUS = '20';

Asteroid.prototype.collideWith = function (otherObject) {
  if (otherObject instanceof Ship) {
    otherObject.relocate();
  }
  if (otherObject instanceof Bullet) {
    this.game.remove(otherObject);
    this.game.remove(this);
  }
};

export default Asteroid;
