const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false,
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true,
  },
};

const newState = [
  {
    id: 3,
    title: 'wash myself',
    body: 'with soap',
    done: false,
  },
  {
    id: 3,
    title: 'wash lolipop',
    body: 'with shampoo',
    done: true,
  },
];

import {
  RECEIVE_TODOS,
  RECEIVE_TODO,
  DELETE_TODO,
} from '../actions/todo_actions';


export const todos_reducer = (state = initialState, action) => {
  Object.freeze(state);
  const nextState = {};
  switch (action.type) {
    case RECEIVE_TODOS:
      // return action.todos.reduce(mapArrToStateReducerCb(action.todos[0]), {});
      action.todos.forEach((todo) => {
        nextState[todo.id] = todo;
      });
      return nextState;
    case RECEIVE_TODO: {
      const todo = { [action.todo.id]: action.todo };
      return { ...state, ...todo };
    }
    case DELETE_TODO: {
      // nextState = Object.assign({}, state);
      // delete nextState[action.todo.id];
      const { [action.id]: _, ...restState } = state;
      return restState;
    }
    default:
      return state;
  }
};
