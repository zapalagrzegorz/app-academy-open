// View
const View = require('./ttt-view.js'); // require appropriate file
const Game = require('./game.js'); // require appropriate file

$(() => {
  // const $tttContainer = $('.ttt');

  // g = new Game();
  // g.run(reader, completion);
  $('body').append($('<figure class="ttt"></figure>)'));

  new View(new Game(), $('.ttt'));

  document.addEventListener('keydown', function (e) {
    if (e.key == 'Escape') {
      $('.ttt').remove();
      $('body').append($('<figure class="ttt"></figure>)'));
      new View(new Game(), $('.ttt'));
    }
  });
  // Your code here
});
