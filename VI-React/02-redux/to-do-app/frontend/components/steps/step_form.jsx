import * as util from '../../util/util';
import React from 'react';
// import receiveStep

export function StepForm({ receiveStep, todo_id }) {
  const { value: title, bind: bindTitle, reset: resetTitle } = util.useInput(
    ''
  );

  const handleSubmit = (e) => {
    e.preventDefault();
    const step = {
      todo_id,
      id: util.uniqueId(),
      done: false,
      title,
    };
    receiveStep(step);
    resetTitle();
  };
  return (
    <form onSubmit={handleSubmit}>
      <div>
        <label>
          title
          <input type="text" {...bindTitle} />
        </label>
      </div>

      <input type="submit" value="Add Step" />
    </form>
  );
}
