import React, { useState } from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

export default function TodoListItem(props) {
  const [detail, setDetail] = useState(false);

  const { title, body, done, id } = props.item;
  const { deleteTodo, updateTodo } = props;

  // const handleDelete = () => {
  //   deleteTodo(id);
  // };

  const handleDone = () => {
    const isDone = !done;
    updateTodo({ title, body, done: isDone, id });
  };

  return (
    <li>
      <h2>{title}</h2>
      <p>
        <button type="button" onClick={handleDone}>
          {done ? 'undone' : 'done'}
        </button>
      </p>
      <button type="button" onClick={() => setDetail(!detail)}>
        {detail ? 'hide' : 'show'} details
      </button>
      {detail && <TodoDetailViewContainer item={props.item} />}
    </li>
  );
}
