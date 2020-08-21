// console.log("Webpack is working!")
import MovingObject from './moving_object';

document.addEventListener('DOMContentLoaded', function () {
  // window.MovingObject = MovingObject;
  const ctx = document.getElementById('game-canvas').getContext('2d');
  //   this.vel = vel;
  // this.radius = radius;
  // this.color = color;
  const conf = {
    pos: [20, 20],
    vel: [3, 4],
    color: '#888',
    radius: 5
  };

  // ctx.fillRect(0, 0, 150, 150);
  const obj = new MovingObject(conf);
  obj.draw(ctx);
  console.log('tet');
});
