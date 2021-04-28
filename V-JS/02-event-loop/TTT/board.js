class Board {
  constructor(reader, completionCallback) {
    this.board = new Array(3).fill().map(() => new Array(3).fill());
    this.reader = reader;
    this.completionCallback = completionCallback;
  }

  isOccupied(field) {
    return field != undefined;
  }

  isOver() {
    return this.winner() || this.board.every((row) => {
      return row.every((column) => this.isOccupied(column));
    });
  }
  winner() {
    const rowWinning = this.board.find((row) => {
      const sing = row[0];
      return row.every((column) => column === sing);
    });

    if (rowWinning) {
      return rowWinning[0];
    }

    if ((this.board[0][0] === this.board[1][0]) == this.board[2][0])
      return this.board[0][0];
    if ((this.board[0][1] === this.board[1][1]) == this.board[2][1])
      return this.board[0][1];
    if ((this.board[0][2] === this.board[1][2]) == this.board[2][2])
      return this.board[0][1];

    if ((this.board[0][0] === this.board[1][1]) == this.board[2][2])
      return this.board[0][0];
  }

  placeMark(pos, mark) {
    const [row, column] = pos;
    if (this.board[row][column] !== undefined) {
      console.log('Invalid move');
      // this.promptUser();
    } else {
      this.board[row][column] = mark;
      console.log(this.board);
    }
  }

  print() {
    this.board.forEach((row) => {
      const rowToPrint = row.map((column) => `${column ? column : ' _ '}`);
      console.log(rowToPrint.join(''));
      console.log('\n');
    });
  }

  validMoves() {
    const validMovesList = [];

    for (let i = 0; i < 3; i++) {
      for (let j = 0; j < 3; j++) {
        if (this.validMove([i, j])) {
          validMovesList.push([i, j]);
        }
      }
    }

    return validMovesList;
  }
}

Board.marks = ['x', 'o'];


module.exports = Board;

