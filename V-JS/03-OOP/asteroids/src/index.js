// console.log("Webpack is working!")
// import MovingObject from './moving_object';
// import Asteroid from './asteroid';
import GameView from './game_view';
import Game from './game';

document.addEventListener('DOMContentLoaded', function () {
  // window.MovingObject = MovingObject;
  const canvas = document.getElementById('game-canvas');
  const ctx = canvas.getContext('2d');
  //   this.vel = vel;
  // this.radius = radius;
  // this.color = color;
  const conf = {
    pos: [130, 100],
    color: '#555',
    radius: 5,
  };

  // const obj = new Asteroid(conf);
  // obj.draw(ctx);
  // console.log('tet');
  const game = new Game();
  canvas.setAttribute('width', Game.DIM_X);
  canvas.setAttribute('height', Game.DIM_Y);
  game.addAsteroids();
  // game.draw(ctx);

  const gameView = new GameView(game, ctx);
  gameView.start();
});
