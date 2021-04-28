import Utils from './utils';
import MovingObject from './moving_object';

function Bullet(options) {
  this.isWrappable = false;
  MovingObject.call(this, options);
}

Utils.inherits(Bullet, MovingObject);

export default Bullet;