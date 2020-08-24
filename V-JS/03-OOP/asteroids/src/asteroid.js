import Util from './utils';
import MovingObject from './moving_object';

function Asteroid(options) {
  MovingObject.call(this, options);
  this.color = Asteroid.COLOR;
  this.radius = Asteroid.RADIUS;
  this.vel = Util.randomVec(10);

}

Util.inherits(Asteroid, MovingObject);
// Pick a default COLOR and RADIUS for Asteroids. Set these as properties of the Asteroid class: Asteroid.COLOR and Asteroid.RADIUS
Asteroid.COLOR = 'darkgrey';
Asteroid.RADIUS = '10';

export default Asteroid;
