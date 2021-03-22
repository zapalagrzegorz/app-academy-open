import { combineReducers } from 'redux';
import { todos_reducer } from './todos_reducer';

export const rootReducer = combineReducers({ todos: todos_reducer });
