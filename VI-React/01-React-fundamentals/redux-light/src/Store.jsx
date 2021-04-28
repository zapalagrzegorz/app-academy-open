/* eslint-disable indent */

// reducers are pure functions that describe how these pieces of data will change in response to actions.
// actions are plain old javascript objects that represent a change that should be made to the state object.
export class Store {
  constructor(rootReducer, initialState, appliedMiddleware) {
    this.rootReducer = rootReducer;
    this.appliedMiddleware = appliedMiddleware;
    // Instead of assigning state to an empty object in the
    // Store#constructor, invoke the rootReducer to create an initial state object
    this.state = initialState;

    // jeżeli metoda korzysta z this, to trzeba go zbindować!!!
    this.getState = this.getState.bind(this);
    this.subscribe = this.subscribe.bind(this);
    this.dispatch = this.dispatch.bind(this);
    this.subscriptions = [];
  }

  getState() {
    return Object.assign({}, this.state);
  }

  // set state(){

  // }

  /**
 * Zwraca reducer [function rootReducer(prevState, action)], który zwraca zaktualizowany stan
 * 
 * RootReducer zawiera wszystkie cząstkowe reducery. Przyjmuje dowolną akcję i odpala
 * wszystkie reducery pytając czy zmieni ona wartość stanu.
 * Generując nowy obiekt stanu albo przyjmuje dotychczasową wartość, albo reducer cząstkowy daje nową wartość 
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
  combineReducers(reducers) {
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
        nextState[key] = !Object.is(prevValue, newValue);

        // można porównać wynik wywołania reducera z dotychczasowym stateValue

        // newState[key] = partialReducer(stateValue, action);
        // stateChanged = true;
      }
      // Inside of rootReducer, think of a way to determine whether or not the given action has modified any keys in your state (Hint: what assumptions are we making about our reducers???). If it has, trigger all of the subscription callbacks and pass them the next state.

      // wzorowo:
      // config to obiekt z 'listą' reducerów
      // Object.keys(config).forEach(k => {
      //   nextState[k] = config[k](prevState[k], action);
      // });
      if (stateChanged) {
        subscriptions.forEach((callback) => {
          callback();
        });
      }
      return Object.assign({}, nextState); // (if anything changed).
    };
  }

  roleReducer(oldRole = null, action) {
    switch (action.type) {
      case 'change role':
        return action.newRole;
      case 'get unemployed':
        return '';
      default:
        return oldRole;
    }
    // return oldRole;
  }

  // // actions into this rootReducer
  // dispatch(action) {
  //   if (this.appliedMiddleware) {
  //     this.appliedMiddleware(this, this.rootReducer)(action);
  //   } else {
  //     this.state = this.rootReducer(this.state, action, this.subscriptions);
  //   }
  // }

  dispatch(action) {
    this.appliedMiddleware(this, (action) => {
      this.state = this.rootReducer(this.state, action, this.subscriptions);
      return this.state;
    })(action);
  }

  // Next, define a subscribe function on the Store prototype that takes a callback
  // and adds it to the array of subscriptions. We also want to control when those
  // subscription callbacks get triggered.
  subscribe(callback) {
    this.subscriptions.push(callback);
  }
  // the reducer always takes the old value and the action
  // and is responsible for returning either a new value or the
  // old value, depending on if it "responds" to that action type
}

const createStore = (...args) => new Store(...args);
