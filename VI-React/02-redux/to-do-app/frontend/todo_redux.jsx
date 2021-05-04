import React from 'react';
import ReactDOM from 'react-dom';
import { Root } from './components/Root';
// import { getTodos } from './util/todo_api_util';
import { fetchTodos } from './actions/todo_actions';

import { configureStore } from './store/store';

import { receiveTodos, deleteTodo } from './actions/todo_actions';
import * as steps from './actions/steps_actions';
import { allTodos } from './reducers/selectors';

// window.getTodos = getTodos;

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

const store = configureStore();

// console.log('allTodos', allTodos(store.getState()));
// window.allTodos = allTodos(store.getState());

document.addEventListener('DOMContentLoaded', function () {
  ReactDOM.render(<Root store={store} />, document.getElementById('root'));
});

// // window.store.getState();
// window.store.dispatch(deleteTodo(4));
// // window.store.getState();
// window.store.dispatch(steps.receiveSteps(newSteps));
// // window.store.getState();
// window.store.dispatch(steps.receiveStep(newStep));
// // window.store.getState();
// window.store.dispatch(steps.deleteStep(3));
// window.store.getState();
