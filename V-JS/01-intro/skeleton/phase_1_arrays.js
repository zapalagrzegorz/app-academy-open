// Array#uniq - returns a new array containing each individual element of the original array only once (creating all unique elements)

//     the elements should be in the order in which they first appear in the original array
//     should not mutate the original array
//     ([1,2,2,3,3,3].uniq() => [1,2,3])

/**
 * użybył new Set
 */
Array.prototype.uniq = function () {
  const uniqArr = [];
  this.forEach((element) => {
    const index = this.indexOf(element);
    if (uniqArr.indexOf(element) == -1) {
      uniqArr.push(element);
    }
  });
  return uniqArr;
};

// console.log([1, 2, 2, 3, 3, 3].uniq());

// Array#twoSum
// returns an array of position pairs where the elements sum to zero
Array.prototype.twoSum = function () {
  const twoSum = [];
  this.forEach((element, index) => {
    this.forEach((nextElement, nextIndex) => {
      if (nextIndex <= index) {
        return;
      }
      if (element + nextElement == 0) twoSum.push([index, nextIndex]);
    });
  });

  return twoSum;
};

// const arr = [1, 2, 3, -2, -3, 0, -1].twoSum();
// console.log(arr);

Array.prototype.transpose = function () {};
