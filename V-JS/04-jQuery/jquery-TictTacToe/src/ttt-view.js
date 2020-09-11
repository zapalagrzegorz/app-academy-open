class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
  }

  bindEvents() {}

  makeMove($square) {}

  // Write a View.prototype.setupBoard method; it should make a grid to represent the board. Build the grid using an unordered list (<ul>). The cells can be represented inside the grid using <li> elements. By giving the <ul> a display property of flex, giving it a fixed width, and setting flex-wrap: wrap the <li> elements will appear as a 3x3 grid. (You need to do some quick division or tinkering to figure out how wide the <li> elements need to be). Set a border on the cells to make it look like a real grid. Style unclicked cells with a gray background. Change the background to yellow while the user :hovers over an unclicked cell.
  setupBoard() {
    const $ul = $('<ul>');
    for (let i = 0; i < 9; i++) {
      $ul.append($('<li>'));
    }
    this.$el.append($ul);
  }
}

module.exports = View;
