import React from 'react';
import StepListContainer from '../steps/step_list_container';

export default function TodoDetailView(props) {
  const { body, id } = props.item;
  const { deleteTodo } = props;
  const handleDelete = () => {
    deleteTodo(id);
  };

  return (
    <>
      <p>Body of todo: {body}</p>
      {/* steps */}
      <StepListContainer todo={props.item} />

      <div>
        <button type="button" onClick={handleDelete}>
          Delete todo item
        </button>
      </div>
    </>
  );
}
