const Util = {
  inherits(childClass, parentClass) {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },
};
// to be tested
export default Util;

// Util.inherits = function (childClass, parentClass) { ... }.
