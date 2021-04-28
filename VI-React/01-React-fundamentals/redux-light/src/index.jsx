import React from 'react';
import ReactDOM from 'react-dom';
import { App } from './app';
import { Store } from './Store';

/**
 * Zwraca reducer (rootReducer), zawierający wszystkie cząstkowe reducery
 * przykład:
 *   {
    users: reducerForUsers,
    roles: reducerForRoles,
    bananas: reducerForBananas,
    entities: reducerForEntities
  }
  * klucz to wartość klucza w stanie, a wartość to reducer
  *
 * Zwracany rootReducer pobiera dotychczasowy stan oraz obiekt akcji (typ akcji i wartość)
 * 
 * @param {object} reducers
 */
function combineReducers(reducers) {
  return function (prevState, action, subscriptions) {
    const nextState = {};
    //  przejdź przez wszystkie klucze i wartosci dotychczasowego stanu
    // za każdą iteracją: twórz nową wartość stanu w oparciu o cząstkowy reducer
    // [ z listy dostępnych szczątkowych reducerów wybierz ten, który odpowiada za wartość wg klucza ze stanu]
    // patrz lista reducerów - reducers
    //  (reducers[key])
    // przekaż mu dotychczasową wartość oraz akcję
    // jeżeli akcja nic nie robi, to zwróci dotychczasową wartość!
    //

    let stateChanged = false;

    for (const key in reducers) {
      const prevValue = prevState[key];
      const partialReducer = reducers[key];
      // pass that value and the action into the appropriate reducer.
      const newValue = partialReducer(prevValue, action);
      if (!stateChanged) {
        stateChanged = !Object.is(prevValue, newValue);
      }

      nextState[key] = newValue;
    }

    if (stateChanged) {
      subscriptions.forEach((callback) => {
        callback(Object.assign({}, nextState));
      });
    }
    // return a new object, with all new values returned from the reducers Test your code!
    return Object.assign({}, nextState); // (if anything changed).
  };
}

// official solution
// const combineReducers = (config) => {
//   return (prevState, action) => {
//     const nextState = {};
//     Object.keys(config).forEach((k) => {
//       if (!action) {
//         const args = [, { type: '__initialize' }];
//         nextState[k] = config[k](...args);
//       } else {
//         nextState[k] = config[k](prevState[k], action);
//       }
//     });
//     return nextState;
//   };
// };

const applyMiddleware = (...middlewares) => (store, cb) => (action) => {
  const middlewaresCopy = [...middlewares];
  const invokeNextMiddleware = (action) => {
    let nextMiddleware = middlewaresCopy.shift();
    if (!nextMiddleware) {
      return cb(action);
    }
    return nextMiddleware(store)(invokeNextMiddleware)(action);
  };
  return invokeNextMiddleware(action);
};

const middleware1 = (store) => (next) => (action) => {
  console.log('Middleware 1!');
  next(action);
};

// Now that you have the ability to applyMiddleware, let's build a tool that logs any changes to state in the console so we can see what's going on. Write a middleware, reduxLogger, that logs

const reduxLogger = (store) => (next) => (action) => {
  console.group('redux logger');
  console.log('%cPrevious state: %o', 'color: brown', store.state);
  console.log('Current action: %o', action);
  console.log('%cNext state: %o', 'color: blue', next(action));
  console.groupEnd();
  next(action);
  // the prevState
  // the action
  // the nextState and labels them appropriately. Note: Getting nextState will be a little tricky since it will only be calculated by the rootReducer. However, if reduxLogger is the last middleware, we could potentially use the return value of next(action). In order for this to work properly, make sure your functions are returning state in all necessary places! Once you can log properly, let's make this tool even flashier by adding some color to the logged output. Some browsers (try chrome) support adding CSS to console.log()'s using the following fisherman's trick ("%c"):
};

const actionCreator1 = (value) => ({
  type: 'add',
  value,
});

const actionCreator2 = (value) => ({
  type: 'subtract',
  value,
});

const actionCreator3 = (value) => ({
  type: 'no change',
  value,
});

const numberReducer = (num = 0, action) => {
  switch (action.type) {
    case 'add':
      return num + action.value;
    case 'subtract':
      return num - action.value;
    default:
      return num;
  }
};

const rootReducer = combineReducers({
  number: numberReducer,
});

const middlewares = applyMiddleware(middleware1, reduxLogger);
const store = new Store(rootReducer, { number: 0 }, middlewares);

store.getState(); // => { number: 0 }

const announceStateChange = (nextState) => {
  console.log(
    `That action changed the state! Number is now ${nextState.number}`
  );
};

store.subscribe(announceStateChange);

store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 5"
store.dispatch(actionCreator1(5)); // => "That action changed the state! Number is now 10"
store.dispatch(actionCreator2(7)); // => "That action changed the state! Number is now 3"
store.dispatch(actionCreator3(7)); // => Nothing should happen! The reducer doesn't do anything for type "no change"
store.dispatch(actionCreator1(0)); // => Nothing should happen here either. Even though the reducer checks for the "add" action type, adding 0 to the number won't result in a state change.

store.getState(); // => { number: 3 }

// document.addEventListener('DOMContentLoaded', () => {
//   ReactDOM.render(<App />, document.getElementById('root'));
// });
