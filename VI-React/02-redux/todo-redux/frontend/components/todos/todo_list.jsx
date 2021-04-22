import React from 'react';
import TodoListItem from './todo_list_item';
import { TodoForm } from './todo_form';

export default function TodoList({ todos, receiveTodo, deleteTodo }) {
  const todosItems = todos.map((item) => (
    <TodoListItem
      key={item.id}
      item={item}
      deleteTodo={deleteTodo}
      receiveTodo={receiveTodo}
    />
  ));

  return (
    <div>
      <TodoForm receiveTodo={receiveTodo}  />
      <h3>Todo List goes here!</h3>
      <ul>{todosItems}</ul>
    </div>
  );
}
