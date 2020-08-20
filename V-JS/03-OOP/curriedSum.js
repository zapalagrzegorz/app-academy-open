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
// const sum = curriedSum(4);
// const result = sum(5)(30)(20)(1); // => 56
// console.log(result);

//     Collect up arguments until there are numArgs of them,
// If there are too few arguments still, it should return itself.
// When there are numArgs arguments, it should call the original function.
// Write a version that uses Function.prototype.apply and another one that uses ... (the spread operator).
Function.prototype.curry = function (numArgs) {
  const args = [];
  const fun = this;

  /* istotą jest wywoływanie argumentów pojedyńczo */
  function _curried(arg) {
    args.push(arg);

    if (args.length === numArgs) {
      // return fun(...args);
      return fun.apply(null, args);
    } else {
      return _curried;
    }
  }

  return _curried;
  // Collect up arguments until there are numArgs of them,
  // If there are too few arguments still, it should return itself.
  // When there are numArgs arguments, it should call the original function.
  // Write a version that uses Function.prototype.apply and another one that uses ... (the spread operator).
};

Function.prototype.curryArrow = function (nArg) {
  const argArray = [];
  const _curriedFn = (arg) => {
    argArray.push(arg);
    if (argArray.length === nArg) {
      // spreading the array into individual arguments
      return this(...argArray); 
    } else {
      return _curriedFn;
    }
  };
  return _curriedFn;
};

function sum(arg1, arg2) {
  return arg1 + arg2;
}

const curriedSumRemake = sum.curryArrow(2);
// Array.prototype.curriedReduce = curriedSum;

const effect = curriedSumRemake(1)(10);
console.log(effect);
