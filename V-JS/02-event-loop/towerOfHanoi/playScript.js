const readline = require('readline');
const { read } = require('fs');
const TowerOfHanoi = require('./towerOfHanoi.js');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function completionCB() {
  reader.question('Do you want to play again? ', (resp) => {
    if (resp === 'yes') {
      new TowerOfHanoi(reader).run(completionCB);
    } else {
      reader.close();
      return;
    }
  });
}

new TowerOfHanoi(reader).run(completionCB);
