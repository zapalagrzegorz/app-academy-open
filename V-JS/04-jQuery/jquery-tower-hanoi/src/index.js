const HanoiGame = require('./game');
const HanoiView = require('./HanoiView');

$(() => {
  const rootEl = $('.hanoi');
  const game = new HanoiGame();
  new HanoiView(game, rootEl);
});
