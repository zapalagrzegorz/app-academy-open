import React from 'react';
import ReactDOM from 'react-dom';
import { configureStore } from './store/store';

import { receiveTodos, deleteTodo } from './actions/todo_actions';

const newState = [
  {
    id: 3,
    title: 'wash myself',
    body: 'with soap',
    done: false,
  },
  {
    id: 4,
    title: 'wash lolipop',
    body: 'with shampoo',
    done: true,
  },
];

window.store = configureStore();

console.log(window.store.getState());
console.log(window.store.dispatch(receiveTodos(newState)));
console.log(window.store.getState());
console.log(window.store.dispatch(deleteTodo(4)));
console.log(window.store.getState());

document.addEventListener('DOMContentLoaded', function () {
  ReactDOM.render(<h1>Todos App</h1>, document.getElementById('content'));
});
