// Your GameView class will be responsible for keeping track of the canvas context, the game, and the ship. Your GameView will be in charge of setting an interval to animate your game. In addition, it will eventually bind key handlers to the ship so that we can move it around.

// Define an GameView class in src/game_view.js. The GameView should store a Game and take in and store a drawing ctx.

// Write a GameView.prototype.start method. It should call setInterval to call Game.prototype.moveObjects and Game.prototype.draw once every

function GameView(game, ctx){
  this.game = game;
  this.ctx = ctx;
}

GameView.prototype.start = function() {
 

  const step = () => {
    this.game.draw(this.ctx);
    this.game.step();
    window.requestAnimationFrame(step);
  };

  window.requestAnimationFrame(step);
};

export default GameView;