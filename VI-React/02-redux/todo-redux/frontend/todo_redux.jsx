import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from './store/store';

import { receiveTodos, deleteTodo } from './actions/todo_actions';
import * as steps from './actions/steps_actions';

const newState = [
  {
    id: 3,
    title: 'wash myself',
    body: 'with oil',
    done: false,
  },
  {
    id: 4,
    title: 'wash lolipop',
    body: 'with gentle water',
    done: true,
  },
];

const newSteps = [
  { id: 1, title: 'Dispatch actions', done: false, todo_id: 3 },
  { id: 2, title: 'go to shop', done: false, todo_id: 4 },
];

const newStep = { id: 3, title: 'buy lolipop', done: false, todo_id: 4 };

const applyMiddlewares = (store, ...middlewares) => {
  // Create a variable dispatch, setting it equal to store.dispatch
  let dispatch = store.dispatch;
  middlewares.forEach((middleware) => {
    // Reassign dispatch to the result of middleware(store)(dispatch)
    dispatch = middleware(store)(dispatch);
    // What is next inside the logging function? It's store.dispatch
  });
  return Object.assign({}, store, { dispatch });
};

const addLoggingToDispatch = (store) => (next) => (action) => {
  // Create a variable dispatch, setting it equal to store.dispatch
  console.log('logging via original middleware');
  console.log(store.getState());
  console.log(action);
  // dispatch(action)
  next(action);
  console.log(store.getState());
};

document.addEventListener('DOMContentLoaded', function () {
  ReactDOM.render(<h1>Todos App</h1>, document.getElementById('content'));

  window.store = configureStore();
  // console.log(window.store.getState());

  // const newStore = applyMiddlewares(window.store, addLoggingToDispatch);

  // window.store = newStore;
  // window.store.getState();
  window.store.dispatch(receiveTodos(newState));
  // window.store.getState();
  window.store.dispatch(deleteTodo(4));
  // window.store.getState();
  window.store.dispatch(steps.receiveSteps(newSteps));
  // window.store.getState();
  window.store.dispatch(steps.receiveStep(newStep));
  // window.store.getState();
  window.store.dispatch(steps.deleteStep(3));
  // window.store.getState();
});
