import Util from './utils';
import MovingObject from './moving_object';

function Ship(options) {
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  options.vel = [0, 0];
  MovingObject.call(this, options);
}

Util.inherits(Ship, MovingObject);
Ship.COLOR = '#fe019a';
Ship.RADIUS = '13';
Ship.MAX_SPEED = 7;

Ship.prototype.relocate = function () {
  this.vel = [0, 0];
  this.pos = this.game.randomPosition();
};

Ship.prototype.power = function (impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
  if (this.vel[0] > Ship.MAX_SPEED) this.vel[0] = Ship.MAX_SPEED;
  if (this.vel[0] < -Ship.MAX_SPEED) this.vel[0] = -Ship.MAX_SPEED;
  if (this.vel[1] > Ship.MAX_SPEED) this.vel[0] = Ship.MAX_SPEED;
  if (this.vel[1] < -Ship.MAX_SPEED) this.vel[0] = -Ship.MAX_SPEED;
};

export default Ship;
