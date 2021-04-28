

class TowerOfHanoi {
  constructor(reader) {
    this.reader = reader;
    this.towers = [[], [1], [3, 2,]];
  }
  promptMove(completionCallback) {
    this.reader.question(
      'Which disk to which tower do you want to move eg. 1,3: ',
      (resp) => {
        const moves = this._parseInput(resp);
        this.move(...moves);
        if (this.isWon()) {
          completionCallback();
        } else {
          this.run();
        }
      }
    );
  }

  isValidMove(startTowerIdx, endTowerIdx) {
    return (
      this._checkIdxValidity(startTowerIdx, endTowerIdx) &&
      this._checkDiscValidity(startTowerIdx, endTowerIdx)
    );
  }

  move(startTowerIdx, endTowerIdx) {
    if (!this.isValidMove(startTowerIdx, endTowerIdx)) {
      console.log('Invalid move');
      return false;
    }

    const startDisc = this.towers[startTowerIdx].pop();
    this.towers[endTowerIdx].push(startDisc);
    return true;
  }

  _parseInput(resp) {
    const [move1, move2] = resp.split(',');
    const start = parseInt(move1) - 1;
    const end = parseInt(move2) - 1;
    return [start, end];
  }

  _checkDiscValidity(startTowerIdx, endTowerIdx) {
    const startTowerLength = this.towers[startTowerIdx].length;
    if (!startTowerLength) return false;

    const endTowerLength = this.towers[endTowerIdx].length;
    if (!endTowerLength) return true;

    const startDisc = this.towers[startTowerIdx][startTowerLength - 1];
    const endDisc = this.towers[endTowerIdx][endTowerLength - 1];

    if (startDisc > endDisc) return false;
    return true;
  }
  _checkIdxValidity(startTowerIdx, endTowerIdx) {
    if (
      startTowerIdx < 0 ||
      endTowerIdx < 0 ||
      startTowerIdx > 3 ||
      endTowerIdx > 3
    ) {
      console.log('You ve given inappropriate indexes');
      return false;
    }
    return true;
  }
  print() {
    console.log(JSON.stringify(this.towers));
  }
  isWon() {
    if (this.towers[2].toString() === '3,2,1') return true;
    return false;
  }
  run(completionCallback) {
    // until tower is moved
    this.print();
    this.promptMove(completionCallback);
    // prompt a move
    // check validity
    // make move on board
    // if(this.isWon()){
    //   complete()
    // }
    // start loop again
  }
}

module.exports = TowerOfHanoi;
