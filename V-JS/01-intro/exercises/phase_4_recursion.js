// receives a start and end value, returns an array from start up to end
const range = (start, end) => {
  const arr = [];
  if (start <= end) {
    arr.push(start);
    return arr.concat(range(start + 1, end));
  }
  return arr;
};

// 1,2

const sumRec = (arr) => {
  if (arr.length > 1) {
    return arr[0] + sumRec(arr.slice(1));
  }
  return arr[0];
};

// console.log(sumRec([1]));

// console.log(sumRec([1, 2, 3]));

// exponent(base, exp) - receives a base and exponent, returns the base raise to the power of the exponent (base ^ exp)
// # version 1
// exp(b, 0) = 1
// exp(b, n) = b * exp(b, n - 1)

const exponent = (base, exp) => {
  if (exp === 0) return 1;
  return base * exponent(base, exp - 1);
};

// console.log(exponent(2, 6));
// exp(b, 0) = 1
// exp(b, 1) = b
// exp(b, n) = exp(b, n / 2) ** 2             [for even n]
// exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
const exp2 = (base, exp) => {
  if (exp === 0) return 1;
  if (exp === 1) return base;

  if (exp % 2 === 0) {
    return exp2(base, exp / 2) ** 2;
  } else {
    return base * exp2(base, (exp - 1) / 2) ** 2;
  }
};

// console.log(exp2(2, 7));

const fibonacci = (n) => {
  if (n === 0) return [];
  if (n === 1) return [0];
  if (n === 2) return [0, 1];

  const fibArr = fibonacci(n - 1); // rFib(4) => [0,1,1]
  const nextFibNum = fibArr[fibArr.length - 1] + fibArr[fibArr.length - 2]; // rFib(4) => [0,1,1]

  fibArr.push(nextFibNum);
  //  # num2 = 1

  return fibArr;
};

// console.log(fibonacci(6));
// } - deep dup of an Array!
const deepDup = (arr) => {
  return arr.map((element) => {
    if (element instanceof Array) {
      return deepDup(element);
    }
    return element;
  });
};

// console.log(deepDup([1, [2, [3, 4]], 5]));
// # nil if not found; can't find anything in an empty array
// return nil if nums.empty?

// probe_index = nums.length / 2
// case target <=> nums[probe_index]
// when -1
//   # search in left
//   bsearchSolution(nums.take(probe_index), target)
// when 0
//   probe_index # found it!
// when 1
//   # search in the right; don't forget that the right subarray starts
//   # at `probe_index + 1`, so we need to offset by that amount.
//   sub_answer = bsearchSolution(nums.drop(probe_index + 1), target)
//   sub_answer.nil? ? nil : (probe_index + 1) + sub_answer
// end
const bsearch = (arr, target) => {
  if (!arr.length) return -1;

  let probeIndex = Math.floor(arr.length / 2);

  const dir =
    arr[probeIndex] > target ? "-1" : arr[probeIndex] < target ? "1" : "0";

  if (dir == "-1") {
    return bsearch(arr.slice(0, probeIndex), target);
  } else if (dir == "0") {
    return probeIndex;
  } else {
    const subAnswer = bsearch(arr.slice(probeIndex + 1), target);
    if (subAnswer == -1) return -1;
    // dopisz przesunięcie o offset - prawą stronę tablicy
    // bo zawsze będzie jakaś wartosć zwrotna
    return subAnswer + probeIndex + 1;
  }
};

// p merge_sort([2, 6, 10, 12, 23, 0, 8, 5, 9, 3, 4])

const merge = (leftArr, rightArr) => {
  const sortedArr = [];
  let leftIndex = 0;
  let rightIndex = 0;
  while (leftIndex < leftArr.length && rightIndex < rightArr.length) {
    if (leftArr[leftIndex] < rightArr[rightIndex]) {
      sortedArr.push(leftArr[leftIndex]);
      leftIndex += 1;
    } else {
      sortedArr.push(rightArr[rightIndex]);
      rightIndex += 1;
    }
  }

  while (leftIndex < leftArr.length) {
    sortedArr.push(leftArr[leftIndex]);
    leftIndex += 1;
  }

  while (rightIndex < rightArr.length) {
    sortedArr.push(rightArr[rightIndex]);
    rightIndex += 1;
  }

  return sortedArr;
};

const mergesort = (arr) => {
  if (arr.length == 1) return arr;

  const leftArr = arr.slice(0, Math.floor(arr.length / 2));
  const rightArr = arr.slice(Math.floor(arr.length / 2));

  const left = mergesort(leftArr);
  const right = mergesort(rightArr);

  return merge(left, right);
};

// console.log(mergesort([2, 6, 10, 12, 23, 0, 8, 5, 9, 3, 4]));
// console.log(mergesort([2, 6]));

const subsets = (arr) => {
  if (!arr.length) return [[]];
  // # debugger
  // # take - return first n elements

  const subArr = arr.slice(0, arr.length - 1);

  const subs = subsets(subArr);

  // # concat Appends the elements of other_ary to self.
  // # tyle co +
  const subArrays = subs.map((sub) => sub.concat(arr[arr.length - 1]));

  return subs.concat(subArrays);
};

console.log(subsets([1, 2, 3]));
