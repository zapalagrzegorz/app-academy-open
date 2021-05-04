import React from 'react';
import StepListContainer from '../steps/step_list_container';

export default function TodoDetailView(props) {
  const { body, id } = props.item;
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
