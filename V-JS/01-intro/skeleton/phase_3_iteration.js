Array.prototype.bubbleSort = function(){
    let sorted = false;
    const arr = this.slice();

    while(!sorted){

        sorted = true
        for(let i=0; i<arr.length-1; i++){
            if(arr[i] > arr[i+1]){
              temp = arr[i]
              arr[i] = arr[i+1];
              arr[i+1] = temp;
              // 
              // [arr[i], arr[i + 1]] = [arr[i + 1], arr[i]];
              sorted = false
            }
        } 
    }

    return arr
}

// console.log([7,82,2,3,333,1,2].bubbleSort());

// String#substrings
// expect(substrings("jump")).to match_array ["j", "ju", "jum", "jump", "u", "um", "ump", "m", "mp", "p"]

String.prototype.substrings = function(){
  const substrings = [];

  str = this.slice().split('');

  str.forEach(function(_element, index){
    str.forEach(function(_nextElement, nextIndex){
      if(nextIndex >= index) substrings.push( str.slice(index, nextIndex+1))
    })
  })
  return substrings;
}

console.log('jump'.substrings());