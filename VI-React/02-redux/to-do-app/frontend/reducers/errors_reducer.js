// frontend/reducers/error_reducer

import { RECEIVE_ERRORS, CLEAR_ERRORS } from '../actions/errors_actions';

export const errors_reducer = (state = [], action) => {
  Object.freeze(state);
  const nextState = [];
  switch (action.type) {
    case RECEIVE_ERRORS:
      action.errors &&
        action.errors.length &&
        action.errors.forEach((error) => {
          nextState.push(error);
        });
      return nextState;

    // new/update
    // case RECEIVE_TODO: {
    //   const todo = { [action.todo.id]: action.todo };
    //   return { ...state, ...todo };
    // }
    case CLEAR_ERRORS: {
      // nextState = Object.assign({}, state);
      // delete nextState[action.todo.id];
      return [];
    }
    default:
      return state;
  }
};
