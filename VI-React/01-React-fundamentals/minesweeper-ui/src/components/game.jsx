import React from 'react';
import * as Minesweeper from './minesweeper';
import { Board } from './board';

export class Game extends React.Component {
  constructor(props) {
    super(props);
    // const board = new Minesweeper.Board();
    // board.generateBoard();
    this.state = {
      board: new Minesweeper.Board(8, 10),
    };

    this.updateGame = this.updateGame.bind(this);
  }

  updateGame() {}

  render() {
    return <Board board={this.state.board} updateGame={this.updateGame} />;
  }
}
