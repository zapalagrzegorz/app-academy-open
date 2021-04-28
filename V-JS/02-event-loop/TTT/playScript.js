const readline = require('readline');
const Game = require('./game.js');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function completionCB() {
  reader.question('Do you want to play again? ', (resp) => {
    if (resp === 'yes') {
      new Game(reader).run(completionCB);
    } else {
      reader.close();
      return;
    }
  });
}

new Game().run(reader, completionCB);
// new Game().promptUser(reader)

// nie sprawdza winner'a
// błedny ruch skipuje kolejke