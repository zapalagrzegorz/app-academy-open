import React, { useEffect } from 'react';
import TodoListItem from './todo_list_item';
import { TodoForm } from './todo_form';

export default function TodoList({
  todos,
  errors,
  createTodo,
  deleteTodo,
  getTodos,
  updateTodo,
  fetchSteps,
}) {
  useEffect(() => {
    getTodos();
    fetchSteps();
  }, []);

  const todosItems = todos.map((item) => (
    <TodoListItem
      key={item.id}
      item={item}
      deleteTodo={deleteTodo}
      updateTodo={updateTodo}
    />
  ));

  const errorsItems = errors.map((error, index) => (
    <li key={index}>{error}</li>
  ));

  return (
    <div>
      {errors.length > 0 && (
        <>
          <h3>There were errors:</h3>
          <ul>{errorsItems}</ul>
        </>
      )}

      <TodoForm createTodo={createTodo} />
      <h3>Todo List goes here!</h3>
      <ul>{todosItems}</ul>
    </div>
  );
}
