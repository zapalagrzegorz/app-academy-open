import * as util from '../../util/util';
import React from 'react';
// import receiveTodo

export function TodoForm({ receiveTodo }) {
  const {
    value: title,
    setValue: setTitle,
    bind: bindTitle,
    reset: resetTitle,
  } = util.useInput('');

  const {
    value: body,
    setValue: setBody,
    bind: bindBody,
    reset: resetBody,
  } = util.useInput('');

  const handleSubmit = (e) => {
    e.preventDefault();
    const todo = {
      id: util.uniqueId(),
      done: false,
      title,
      body,
    };
    receiveTodo(todo);
  };
  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>
          title
          <input type="text" {...bindTitle} />
        </label>
      </div>
      <div>
        <label>
          body
          <textarea {...bindBody} />
        </label>
      </div>

      <input type="submit" value="Add todo" />
    </form>
  );
}
