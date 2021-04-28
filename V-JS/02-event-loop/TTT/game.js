const Board = require('./board');



class Game {
  constructor() {
    // this.circle = player1;
    // this.cross = player2;
    // this.activePlayer = this.circle;
    this.board = new Board();
    this.activePlayer = Board.marks[0];
  }

  isOver() {
    return this.board.isOver();
  }

  playMove(pos) {
    console.log(this.activePlayer);
    this.board.placeMark(pos, this.activePlayer);
    this.changePlayer();
  }

  changePlayer() {
    if (this.activePlayer === Board.marks[0]) {
      this.activePlayer = Board.marks[1];
    } else {
      this.activePlayer = Board.marks[0];
    }
  }

  promptUser(reader, callback) {
    this.board.print();
    console.log(`Current Turn: ${this.activePlayer}`);

    reader.question('Which field do you want to mark: ', (resp) => {
      const [x, y] = resp.split(',');
      callback([x, y]);
    });
  }

  winner() {
    return this.board.winner();
  }

  run(reader, gameCompletionCallback) {
    this.promptUser(reader, (move) => {
      this.playMove(move);
      
      if (this.isOver()) {
        this.board.print();
        if (this.winner()) {
          console.log(`${this.winner()} has won!`);
        } else {
          console.log('NO ONE WINS!');
        }
        gameCompletionCallback();
      } else {
        // continue loop
        this.run(reader, gameCompletionCallback);
      }
    });
  }
}

module.exports = Game;