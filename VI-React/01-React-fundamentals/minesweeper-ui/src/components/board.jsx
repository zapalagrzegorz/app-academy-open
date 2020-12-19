import React from 'react';
import * as Minesweeper from './minesweeper';
import { Tile } from './tile';

export class Board extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputText: '' };

    this.buildRows = this.buildRows.bind(this);
    this.renderTiles = this.renderTiles.bind(this);
  }

  buildRows() {
    const grid = this.props.board.grid;
    return grid.map((row, rowIndex) => {
      return (
        <div className="flex-container" key={rowIndex}>
          {this.renderTiles(row, rowIndex)}
        </div>
      );
    });
  }

  renderTiles(row, rowIndex) {
    return row.map((tile, column) => (
      <Tile
        key={(rowIndex, column)}
        tile={tile}
        updateGame={this.props.updateGame}
      />
    ));
  }

  render() {
    const board = this.props.board;
    return <div>{this.buildRows()}</div>;
  }
}
