const MoveError = require('./moveError');

class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  }

  // Write a View.prototype.bindEvents method. When a user clicks on a cell, call Game.prototype.playMove to register their move. Manipulate the cell <li> to show the current player's mark. Add/remove CSS classes to change the cell background to white and display the 'X's and 'O's in different colors. I did all this in a View.prototype.makeMove method. I also popped an alert if the move was invalid.
  bindEvents() {
    this.$el.on('click', 'li', (e) => {
      this.makeMove($(e.currentTarget));
    });


  }

  makeMove($square) {
    const currentPlayer = this.game.currentPlayer;
    const pos = $square.data('pos');
    try {
      this.game.playMove(pos);
      $square.addClass('marked').text(currentPlayer);
      if (this.game.isOver()) {
        const winner = this.game.winner();
        if (winner) {
          this.$el.append(`<h1>${winner} wins!</h1>`);
          this.$el.addClass('over');
          this.$el.find(`li:contains(${winner})`).addClass('win');
        } else {
          this.$el.append('Draw!');
        }
      }
    } catch (e) {
      if (e instanceof MoveError) {
        alert(e.msg);
      } else {
        throw e;
      }
    }
  }

  setupBoard() {
    // this.$el.empty();

    const $ul = $('<ul>');
    for (let row = 0; row < 3; row++) {
      for (let column = 0; column < 3; column++) {
        const $li = $('<li>').data('pos', [row, column]);
        $ul.append($li);
      }
    }
    this.$el.append($ul);
  }
}

module.exports = View;
