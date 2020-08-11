const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers (sum, numLeft, completionCallback) {
  if (numLeft > 0) {
    // Prompt the user for a number (use reader).
    reader.question('Give the number', (res) => {
      // first = res;
      // addNumbersAndIncrement(res, sum);
      const num = parseInt(res);
      sum += num;
      numLeft = numLeft-1;
      console.log(`Sum is now ${sum}`);
      addNumbers(sum, numLeft, completionCallback);
    });

  }
  if (numLeft === 0) {
    completionCallback(sum);
  }
}


addNumbers(0, 3, sum => {
  console.log(`Total Sum: ${sum}`);
  reader.close();
});