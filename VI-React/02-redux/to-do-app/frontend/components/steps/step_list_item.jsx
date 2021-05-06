import React from 'react';

export default function StepListItem(props) {
  const { title, done, id, todo_id } = props.step;
  const { destroyStep, updateStep } = props;

  const handleDelete = () => {
    destroyStep(props.step);
  };

  const handleDone = () => {
    const isDone = !done;
    updateStep({ title, done: isDone, id, todo_id });
    // gdyby było więcej propertiesów to można by tworzyć obiekt przez scalenie
    // const toggledStep = Object.assign({}, this.props.step, {
    //   done: !this.props.step.done,
    // });
  };

  return (
    <li>
      <h2>{title}</h2>
      <p>
        <button type="button" onClick={handleDone}>
          {done ? 'undone' : 'done'} step
        </button>
      </p>
      <div>
        <button type="button" onClick={handleDelete}>
          Delete step
        </button>
      </div>
    </li>
  );
}
