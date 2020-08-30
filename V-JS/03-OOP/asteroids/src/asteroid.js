import Util from './utils';
import MovingObject from './moving_object';

function Asteroid(options) {
  options.color = Asteroid.COLOR;
  options.radius = Asteroid.RADIUS;
  MovingObject.call(this, options);
  this.vel = Util.randomVec(5);
}

Util.inherits(Asteroid, MovingObject);
// Pick a default COLOR and RADIUS for Asteroids. 
// Set these as properties of the Asteroid class: Asteroid.COLOR and Asteroid.RADIUS
Asteroid.COLOR = 'darkgrey';
Asteroid.RADIUS = '20';

export default Asteroid;
