// View
const View = require('./ttt-view.js'); // require appropriate file
const Game = require('./game.js'); // require appropriate file

$(() => {
  const $tttContainer = $('.ttt');

  const view = new View(new Game(), $tttContainer);

  // Your code here
});
