/* globals key */

// Your GameView class will be responsible for keeping track of the canvas context, the game, and the ship. Your GameView will be in charge of setting an interval to animate your game. In addition, it will eventually bind key handlers to the ship so that we can move it around.

// Define an GameView class in src/game_view.js. The GameView should store a Game and take in and store a drawing ctx.

// Write a GameView.prototype.start method. It should call setInterval to call Game.prototype.moveObjects and Game.prototype.draw once every

import key from 'keymaster';

function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  this.bindKeyHandlers();

  const step = () => {
    this.game.draw(this.ctx);
    this.game.step();
    window.requestAnimationFrame(step);
  };

  window.requestAnimationFrame(step);
};

GameView.prototype.bindKeyHandlers = function () {
  // space, up, down, left, right
  key('up', () => {
    this.game.ship.power([0, -1]);
  });
  key('down', () => {
    this.game.ship.power([0, 1]);
  });
  key('left', () => {
    this.game.ship.power([-1, 0]);
  });
  key('right', () => {
    this.game.ship.power([1, 0]);
  });

  key('space', () => {
    this.game.ship.fireBullet();
  });
};

export default GameView;
