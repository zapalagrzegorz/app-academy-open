import Util from './utils';
import MovingObject from './moving_object';
import Bullet from './bullet';

function Ship(options) {
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  options.vel = [0, 0];
  MovingObject.call(this, options);
}

Util.inherits(Ship, MovingObject);
Ship.COLOR = '#fe019a';
Ship.RADIUS = '13';
Ship.MAX_SPEED = 5;

Ship.prototype.relocate = function () {
  this.vel = [0, 0];
  this.pos = this.game.randomPosition();
};

Ship.prototype.power = function (impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
  if (this.vel[0] > Ship.MAX_SPEED) this.vel[0] = Ship.MAX_SPEED;
  if (this.vel[0] < -Ship.MAX_SPEED) this.vel[0] = -Ship.MAX_SPEED;
  if (this.vel[1] > Ship.MAX_SPEED) this.vel[1] = Ship.MAX_SPEED;
  if (this.vel[1] < -Ship.MAX_SPEED) this.vel[1] = -Ship.MAX_SPEED;
};

Ship.prototype.fireBullet = function () {
  if(!this.vel[0] && !this.vel[1]) return;

  let Yvel = 0;
  let Xvel = 0;

  if (this.vel[0] > 0) {
    Yvel = this.vel[0] + 2;
  } else if(this.vel[0] < 0){
    Yvel = this.vel[0] - 2;
  }

  if (this.vel[1] > 0) {
    Xvel = this.vel[1] + 2;
  } else if(this.vel[1] < 0){
    Xvel = this.vel[1] - 2;
  }

  // setupBulletVelocity(vel)

  const options = {
    pos: [this.pos[0] - this.radius, this.pos[1] - this.radius],
    vel: [Yvel, Xvel],
    radius: 2,
    color: 'blue',
    game: this.game,
  };
  const bullet = new Bullet(options);
  // Add the bullet to an array of Game bullets.
  this.game.add(bullet);
};

export default Ship;
