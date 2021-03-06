let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid() {
  const grid = Array(8)
    .fill()
    .map(() => Array(8).fill());
  grid[3][3] = new Piece("white");
  grid[4][4] = new Piece("white");
  grid[3][4] = new Piece("black");
  grid[4][3] = new Piece("black");
  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board() {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [0, 1],
  [1, 1],
  [1, 0],
  [1, -1],
  [0, -1],
  [-1, -1],
  [-1, 0],
  [-1, 1],
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  // pos - [x,y]
  const [x, y] = pos;
  if (x < 0 || y < 0) return false;
  if (x > 7 || y > 7) return false;
  return true;
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (!this.isValidPos(pos)) throw new Error("Invalid position");
  const [x, y] = pos;

  return this.grid[x][y];
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  const piece = this.getPiece(pos)
  if (piece && piece.color === color) return true;
  return false;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  if (this.getPiece(pos)) return true;
  return false;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function (pos, color, dir, piecesToFlip) {
  const [x, y] = dir;
  const [posX, posY] = pos;
  const newPos = [posX + x, posY + y];
  piecesToFlip = piecesToFlip ? piecesToFlip : [];

  if (!this.isValidPos(pos) || !this.isValidPos(newPos)) return [];
  
  if (!this.isOccupied(newPos)) return [];

  if (this.isOccupied(newPos) && this.isMine(newPos, color))
    return piecesToFlip;

  piecesToFlip.push(newPos);

  return this._positionsToFlip(newPos, color, dir, piecesToFlip);
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  // is not already occupied
  if (this.isOccupied(pos)) return false;

  const val = Board.DIRS.some(
    (dir) => this._positionsToFlip(pos, color, dir).length
  );
  return val;
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) throw new Error("Invalid move");
  const [x, y] = pos;
  this.grid[x][y] = new Piece(color);
  Board.DIRS.forEach((dir) => {
    const positionsToFlip = this._positionsToFlip(pos, color, dir);
    positionsToFlip.forEach((posToFlip) => this.getPiece(posToFlip).flip());
  });
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  const validMoves = []
  // checks empty space,
  // if isValid, push
  this.grid.forEach( (row, rowIndex)=>{
    row.forEach( (_, columnIndex)=> {
      if(this.validMove([rowIndex,columnIndex], color)){
        validMoves.push([rowIndex,columnIndex]) 
      } 
    })
  })
  return validMoves
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  if(this.validMoves(color).length) return true;
  return false
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  if(!this.hasMove('white') && !this.hasMove('black')){
    return true;
  }
  return false
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  console.log('  01234567');
  this.grid.forEach( (row, rowIndex)=>{
    const rowLog = [rowIndex, ' '];
    row.forEach( (_, columnIndex)=>{
      if(this.isOccupied([rowIndex, columnIndex])){
        rowLog.push(this.getPiece([rowIndex, columnIndex]));
      } else{
        rowLog.push('_')
      }
    });
    console.log(rowLog.join(""))
  })
 
};

module.exports = Board;
