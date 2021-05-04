// import React from 'react';

import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos, allErrors } from '../../reducers/selectors';
import {
  createTodo,
  deleteTodo,
  updateTodo,
  fetchTodos,
} from '../../actions/todo_actions';

const mapStateToProps = (state) => ({
  todos: allTodos(state),
  errors: allErrors(state),
});

const mapDispatchToProps = (dispatch) => ({
  getTodos: () => dispatch(fetchTodos()),
  createTodo: (todo) => dispatch(createTodo(todo)),
  updateTodo: (todo) => dispatch(updateTodo(todo)),
  deleteTodo: (id) => dispatch(deleteTodo(id)),
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
