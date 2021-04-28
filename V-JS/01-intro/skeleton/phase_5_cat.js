// ES5 class syntax is very different from Ruby. Here we will be creating a Cat class via a constructor function and adding instance variables by building out Cat.prototype. This syntax may seem very strange, but it fit quite nicely into the "Everything is an object" model.

function Cat(name, owner){
  this.name = name;
  this.owner = owner;
}
// Write Cat.prototype.cuteStatement method that returns "[owner] loves [name]"
// cuteStatement should be defined on the prototype

Cat.prototype.cuteStatement = function(){
  return `${this.owner} loves ${this.name}`;
};

// Prototypes example:
// Create several Cat instances, test out their cuteStatement method
// Reassign the Cat.prototype.cuteStatement method with a function that returns "Everyone loves [name]!"
// Invoke the cuteStatement method on your old cats; the new method should be invoked

const cat1 = new Cat('Kitty', 'Marcin');
const cat2 = new Cat('Kitty2', 'Grzegorz');
const cat3 = new Cat('Kitty3', 'Maciej');

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());
console.log(cat3.cuteStatement());

Cat.prototype.cuteStatement = function(){
  return `Everyone loves ${this.name}!`;
};

console.log(cat1.cuteStatement());
console.log(cat2.cuteStatement());
console.log(cat3.cuteStatement());

// Add a meow method to the Cat class You can now call meow on your previously constructed Cat instances
// Take one of your cats and set the meow property on the instance (cat1.meow = function () { ... }. Call meow on this Cat instance; call meow on any other cat. The other cats should continue to use the prototype method.

Cat.prototype.meow = function(){
  return `${this.name} meows`;
};

console.log(cat1.meow());
console.log(cat2.meow());

cat1.meow = function(){
  return `${this.name} roars`;
};

console.log(cat1.meow());
console.log(cat2.meow());