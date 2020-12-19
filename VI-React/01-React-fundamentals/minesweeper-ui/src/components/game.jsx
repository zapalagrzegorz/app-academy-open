import React from 'react';
import * as Minesweeper from './minesweeper';
import { Board } from './board';

export class Game extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      board: new Minesweeper.Board(8, 10),
      endGame: false,
    };

    this.updateGame = this.updateGame.bind(this);
    this.restartGame = this.restartGame.bind(this);
  }

  updateGame(tile, isRevealing) {
    if (isRevealing) {
      tile.explore();
    } else {
      tile.toggleFlag();
    }
    const endGame = this.state.board.won() || this.state.board.lost();
    this.setState({ board: this.state.board, endGame });
  }

  restartGame() {
    const board = new Minesweeper.Board(8, 10);
    const endGame = false;

    this.setState({ board, endGame });
  }

  render() {
    let endGameText;
    if (this.state.endGame) {
      if (this.state.board.won()) {
        endGameText = "you've won";
      } else {
        endGameText = "you've lost";
      }
    }
    const endGameBox = (
      <div className="modal-screen">
        <div className="modal-content">
          <div className="modal-inner-content">
            <p>{endGameText}</p>
            <button className="btn" onClick={this.restartGame}>
              <strong>Play Again!</strong>
            </button>
          </div>
        </div>
      </div>
    );
    return (
      <div>
        {this.state.endGame ? endGameBox : ''}
        <Board board={this.state.board} updateGame={this.updateGame} />;
      </div>
    );
  }
}
