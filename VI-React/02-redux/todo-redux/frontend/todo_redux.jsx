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

window.store = configureStore();

console.log(window.store.getState());
console.log(window.store.dispatch(receiveTodos(newState)));
console.log(window.store.getState());
console.log(window.store.dispatch(deleteTodo(4)));
console.log(window.store.getState());
console.log(window.store.dispatch(steps.receiveSteps(newSteps)));
console.log(window.store.getState());
console.log(window.store.dispatch(steps.receiveStep(newStep)));
console.log(window.store.getState());
console.log(window.store.dispatch(steps.deleteStep(3)));
console.log(window.store.getState());

document.addEventListener('DOMContentLoaded', function () {
  ReactDOM.render(<h1>Todos App</h1>, document.getElementById('content'));
});
