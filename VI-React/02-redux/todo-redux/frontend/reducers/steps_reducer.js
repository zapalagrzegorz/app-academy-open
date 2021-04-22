const initialState = {
  1: {
    id: 1,
    todo_id: 1,
    title: 'buy liquid',
    done: false,
  },
  2: {
    id: 2,
    todo_id: 1,
    title: 'wash dog',
    done: true,
  },
  3: {
    id: 3,
    todo_id: 2,
    title: 'example',
    done: false,
  },
};

// const newState = [
//   {
//     id: 3,
//     title: 'wash myself',
//     body: 'with soap',
//     done: false,
//   },
//   {
//     id: 3,
//     title: 'wash lolipop',
//     body: 'with shampoo',
//     done: true,
//   },
// ];

import {
  RECEIVE_STEPS,
  RECEIVE_STEP,
  DELETE_STEP,
} from '../actions/steps_actions';

// import { mapArrToStateReducerCb } from './root_reducer';

export const steps_reducer = (state = initialState, action) => {
  Object.freeze(state);
  const nextState = {};
  switch (action.type) {
    case RECEIVE_STEPS:
      // return action.steps.reduce(mapArrToStateReducerCb(action.steps[0]), {});
      action.steps.forEach((step) => {
        nextState[step.id] = step;
      });
      return nextState;
    case RECEIVE_STEP: {
      return { ...state, [action.step.id]: action.step };
    }
    case DELETE_STEP: {
      const { [action.id]: _, ...newState } = state;
      return newState;
    }
    default:
      return state;
  }
};

// function mapTodosToState(acc, curr) {
//   acc[curr.id] = {
//     id: curr.id,
//     title: curr.title,
//     body: curr.body,
//     done: curr.done,
//   };
//   return acc;
// }
