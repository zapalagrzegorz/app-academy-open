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
console.log(mappedArr);
