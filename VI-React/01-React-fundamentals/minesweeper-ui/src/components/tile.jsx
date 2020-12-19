import React from 'react';
import * as Minesweeper from './minesweeper';

export class Tile extends React.Component {
  constructor(props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    const isRevealing = event.altKey ? false : true;

    this.props.updateGame(this.props.tile, isRevealing);
  }

  render() {
    // Update your render logic to change the text of the tile based on whether it has been revealed, is bombed, or is flagged. If it's been revealed and has more than one adjacent bomb, show that number. For bombs and flags, use Unicode!
    const tile = this.props.tile;
    let content;

    if (tile.bombed) {
      content = '💣';
    }

    let tileClassBombs = '';
    const bombs = tile.adjacentBombCount();
    switch (bombs) {
      case 1:
        tileClassBombs += ' blue';
        break;
      case 2:
        tileClassBombs += ' black';
        break;
      case 3:
        tileClassBombs += ' violet';
        break;
      case 4:
        tileClassBombs += ' orange';
        break;
      default:
        tileClassBombs += ' red';
        break;
    }
    
    let tileContent = '';

    if (tile.flagged) {
      tileContent = '🚩';
    }
        
    let tileClass = 'tile';

    if (tile.explored) {
      tileClass += ` explored ${tileClassBombs}`;
      tileContent = content ? content : bombs ? bombs : '';
    }

    return (
      <div className={tileClass} onClick={this.handleClick}>
        {tileContent}
      </div>
    );
  }
}
