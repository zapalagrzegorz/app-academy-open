import { combineReducers } from 'redux';
import { steps_reducer } from './steps_reducer';
import { todos_reducer } from './todos_reducer';

export const rootReducer = combineReducers({
  todos: todos_reducer,
  steps: steps_reducer,
});

/**
 * Funkcja dekorująca callback dla funkcji reducer.
 * W oparciu o wzorcowy obiekt mapuje tablicę obiektów w obiekt
 * o kształcie { obiekt.id : {obiekt} }
 *
 * w {} o kształcie: { id : {todo} }
 * @param {object} acc obiekt akumulatora
 * @param {object} curr obiekt w danej iteracji
 * @returns obiekt akumulatora
 */
export function mapArrToStateReducerCb(configObject) {
  const keys = Object.keys(configObject);

  return (acc, curr) => {
    const item = {};
    for (const key of keys) {
      item[key] = curr[key];
    }
    acc[curr.id] = item;
    return acc;
  };
}
