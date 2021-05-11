import React, { useEffect } from 'react';
import StepListContainer from '../steps/step_list_container';

export default function TodoDetailView(props) {
  const { body, id, tags } = props.item;
  const { destroyTodo } = props;

  // receiveSteps nie jest używany?
  // stepList otrzymuje listę stepów... - jak gdzie?
  // StepListContainer korzystając z props'a todo wyciąga ze stanu
  // steps'y, których id_todo pasuje do id propsa, i w ten sposób
  // wrapuje StepList w slice state'u

  const handleDelete = () => {
    destroyTodo(props.item);
    // props.item
  };

  const tagList = tags.map(({ name: tagName }, index) => (
    <li key={index}>{tagName}</li>
  ));

  return (
    <>
      {tagList.length > 0 ? (
        <>
          <p>Tags:</p>
          <ul>{tagList}</ul>
        </>
      ) : (
        ''
      )}

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
