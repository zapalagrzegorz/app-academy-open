function mysteryScoping1() {
  var x = "out of block";
  if (true) {
    var x = "in block";
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping2() {
  const x = "out of block";
  if (true) {
    const x = "in block";
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping3() {
  const x = "out of block";
  if (true) {
    // var x = "in block";
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping4() {
  let x = "out of block";
  if (true) {
    let x = "in block";
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping5() {
  let x = "out of block";
  if (true) {
    let x = "in block";
    console.log(x);
  }
  // let x = "out of block again";
  console.log(x);
}

// mysteryScoping1();
// mysteryScoping4();

// madLib("make", "best", "guac");
// "We shall MAKE the BEST GUAC."
function madLib(verb, adj, noun) {
  console.log(
    `We shall ${verb.toUpperCase()} the ${adj.toUpperCase()} ${noun.toUpperCase()}.`
  );
}

// isSubstring

// Input

//     1) A String, called searchString.
//     2) A String, called subString.

const isSubstring = (searchString, subString) => {
  return searchString.includes(subString);
};
// Output: A Boolean. true if the subString is a part of the searchString.
// console.log(isSubstring("time to program", "time"));
// console.log(isSubstring("Jump for joy", "joys"));

// fizzBuzz

// 3 and 5 are magic numbers.

// Define a function fizzBuzz(array) t
// that takes an array and returns a new array of every
// number in the array that is divisible by either 3 or 5, but not both.
const fizzBuzz = (array) => {
  const fizzBuzzNums = [];
  for (item of array) {
    if (item % 3 === 0 && item % 5 != 0) fizzBuzzNums.push(item);
    if (item % 3 !== 0 && item % 5 === 0) fizzBuzzNums.push(item);
  }
  return fizzBuzzNums;
};

// console.log(fizzBuzz([3, 5, 9, 15]));
const isPrime = (number) => {
  max = number / 2;
  for (let i = 2; i <= max; i++) {
    if (number % i === 0) return false;
  }
  return true;
};

// console.log(isPrime(2));
// // true

// console.log(isPrime(10));
// // false

// console.log(isPrime(15485863));
// // true

// console.log(isPrime(3548563));
// false

// sumOfNPrimes;

// Using firstNPrimes, write a function sumOfNPrimes(n) that returns the sum of the first n prime numbers. Hint: use isPrime as a helper method.
const firstNPrimes = (n) => {
  nPrimes = [];
  let i = 2;
  while (nPrimes.length < n) {
    if (isPrime(i)) nPrimes.push(i);
    i++;
  }
  return nPrimes;
};

// console.log(firstNPrimes(5));

const sumOfNPrimes = (n) => {
  return firstNPrimes(n).reduce((acc, val) => acc + val);
};

console.log(sumOfNPrimes(5));
