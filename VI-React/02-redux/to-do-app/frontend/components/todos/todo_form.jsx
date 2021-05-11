import * as util from '../../util/util';
import React, { useState } from 'react';
// import receiveTodo

export function TodoForm({ createTodo }) {
  const [tag_names, setTags] = useState([]);

  const tagList = tag_names.map((tag, index) => (
    <li key={index}>
      {tag}
      <button type="button" onClick={() => handleRemoveTag(index)}>
        x
      </button>
    </li>
  ));

  const handleRemoveTag = (idx) => {
    const oldTags = [...tag_names];
    oldTags.splice(idx, 1);
    setTags([...oldTags]);
  };

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

  const {
    value: tag,
    setValue: setTag,
    bind: bindTag,
    reset: resetTag,
  } = util.useInput('');

  const handleTagSave = (e) => {
    setTags([...tag_names, tag]);
    resetTag();
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const todo = {
      id: util.uniqueId(),
      done: false,
      title,
      body,
      tag_names,
    };

    createTodo(todo).done(() => {
      // run only on success of promise of createTodo
      resetTitle();
      resetBody();
    });
  };

  return (
    <>
      <h2>Add new item to the list!</h2>
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

        {tagList.length > 0 ? (
          <>
            <p>Tags:</p>
            <ul>{tagList}</ul>
          </>
        ) : (
          ''
        )}

        <label>
          Add new tag
          <input type="text" {...bindTag} />
        </label>
        <button type="button" onClick={handleTagSave}>
          Save tag
        </button>

        <input type="submit" value="Add todo" />
      </form>
    </>
  );
}
