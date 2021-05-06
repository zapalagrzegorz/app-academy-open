import React from 'react';
import ReactDOM from 'react-dom';
import { Root } from './components/Root';
// import { getTodos } from './util/todo_api_util';
import { fetchTodos } from './actions/todo_actions';

import { configureStore } from './store/store';

import { receiveTodos, deleteTodo } from './actions/todo_actions';
import * as steps from './actions/steps_actions';
import { allTodos } from './reducers/selectors';

const store = configureStore();

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
