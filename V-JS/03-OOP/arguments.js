// sum(1, 2, 3, 4) === 10;
function sum(...args) {
  return args.reduce((acc, next) => {
    return acc + next;
  });
}
console.log(sum(1, 2, 3, 4, 5) === 15);
