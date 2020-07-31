Array.prototype.myEach = function (callback) {
  const length = this.length;
  for (let i = 0; i < length; i++) {
    callback(this[i]);
    // (this[i]) => map.push(functionX(this[i]))
  }
};

// [1, 2, 3, 5].myEach((element) => console.log(element * 2));

// Array#myMap(callback) - receives a callback function,
// returns a new array of the results of calling the callback function on each element of the array

// should use myEach and a closure

Array.prototype.myMap = function (callback) {
  const map = [];
  this.myEach((element) => map.push(callback(element)));

  return map;
};

const mappedArr = [1, 2, 3, 5].myMap((element) => element * 2);
// console.log(mappedArr);

// Array#myReduce(callback[, initialValue]) - (like Ruby's Array#inject) receives a callback function, and optional initial value, returns an accumulator by applying the callback function to each element and the result of the last invocation of the callback (or initial value if supplied)

// initialValue is optional and should default to the first element of the array if not provided
// examples:

// // without initialValue
// [1, 2, 3].myReduce(function(acc, el) {
//   return acc + el;
// }); // => 6

// // with initialValue
// [1, 2, 3].myReduce(function(acc, el) {
//   return acc + el;
// }, 25); // => 31
// should also use myEach

// NB [initialValue] is the conventional way for documentation to express that the args between [ and ] are optional inputs. Your function definition will not include these square brackets.

Array.prototype.myReduce = function (callback, initialValue) {
  let arr, acc;

  if (initialValue === undefined) {
    initialValue = this[0];
    arr = this.slice(1);
  }

  acc = initialValue || 0;

  arr.myEach((el) => {
    acc = callback(acc, el);
  });

  return acc;
};

const sum = (acc, curr) => {
  return acc + curr;
}

const theirReduce = [1, 2, 3].reduce(sum);

const myReduceResult = [1, 2, 3].myReduce(sum);

console.log(theirReduce);
console.log(myReduceResult);