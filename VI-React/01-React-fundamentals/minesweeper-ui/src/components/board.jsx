import React from 'react';
import * as Minesweeper from './minesweeper';
import { Tile } from './tile';

export class Board extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputText: '' };
  }
  render() {
    /* Inside of this, use Array#map on the grid of this.props.board to return a <div> component for each row. Remember that the function passed to map is given two arguments, the object and the index, both of which we'll need here. */

    function buildRow(row, index) {
      return (
        <div key={index} className="flex-container">
          {row.map((tile, tileIndex) => (
            <div key={(index, tileIndex)}>
              <Tile tile={tile} />
            </div>
          ))}
        </div>
      );
    }

    return <div>{this.props.board.grid.map(buildRow)}</div>;
  }
}
