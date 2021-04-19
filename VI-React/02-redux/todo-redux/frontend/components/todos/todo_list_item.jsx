import React from 'react';

export default function TodoListItem(props) {
  const { title, body, done } = props.item;
  return (
    <li>
      <h2>{title}</h2>
      <p>{body}</p>
      <p>Is done: {done ? 'yes' : 'nope'}</p>
    </li>
  );
}
