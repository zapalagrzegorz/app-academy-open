import React from 'react';
import * as Minesweeper from './minesweeper';

export class Tile extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputText: '' };
  }
  render() {
    return 'T';
  }
}
