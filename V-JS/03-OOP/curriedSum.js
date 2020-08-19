function curriedSum(numArgs) {
  const numbers = [];
  return function _curriedSum(number) {
    numbers.push(number);
    if (numbers.length === numArgs) {
      return numbers.reduce((acc, curr) => acc + curr);
    } else {
      return _curriedSum;
    }
  };
}
const sum = curriedSum(4);
const result = sum(5)(30)(20)(1); // => 56
console.log(result);