// Throttling jest prostszy od debounce'owania
// Określa minimalny czas bez wywołania funkcji
// np. okno czasowe wynosi 1s, 3 wywołania w odstępie 0,5s spowodują wywołanie
// pierwsze (czas 0) oraz trzecie (1,5s), drugie będzie pominięte

// W debounce'ingu wywołany będzie tylko 3 w czasie 2,5 sek - odroczenie 1 sekunda, od ostatniego wywołania

Function.prototype.myThrottle = function (interval) {
  let tooSoon = false;
  return () => {
    if (tooSoon) return;

    tooSoon = true;
    //   use setTimeout to set tooSoon back to false after interval milliseconds
    setTimeout(() => (tooSoon = false), interval);
    this.apply(null, arguments);
  };
  // argument and return a "throttled" version of the original function that can only be invoked every interval milliseconds
};

class Neuron {
  fire() {
    console.log("Firing!");
  }
}

const neuron = new Neuron();
// When we create a new Neuron,
// we can call #fire as frequently as we want

// The following code will try to #fire the neuron every 10ms. Try it in the console:
// const interval = setInterval(() => {
//   neuron.fire();
// }, 10);
// interval();
// You can use clearInterval to stop the firing:
// clearInterval(interval);

// Using Function#myThrottle, we should be able to throttle
// the #fire function of our neuron so that it can only fire
// once every 500ms:

neuron.fire = neuron.fire.myThrottle(500);

const interval = setInterval(() => {
  neuron.fire();
}, 10);

// This time, if our Function#myThrottle worked correctly,
// the Neuron#fire function should only be able to execute
// every 500ms, even though we're still trying to invoke it
// every 10ms!

// If we want this behavior for ALL neurons, we can do the same logic in the constructor:

//   class Neuron {
//     constructor() {
//       this.fire = this.fire.myThrottle(500);
//     }

//     fire() {
//       console.log("Firing!");
//     }
//   }
