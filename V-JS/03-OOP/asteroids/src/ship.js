import Util from './utils';
import MovingObject from './moving_object';

function Ship(options){
  options.color = Ship.COLOR;
  options.radius = Ship.RADIUS;
  options.vel = [0,0];
  MovingObject.call(this, options);
}

Util.inherits(Ship, MovingObject);
Ship.COLOR = '#fe019a' ;
Ship.RADIUS = '13';

export default Ship;