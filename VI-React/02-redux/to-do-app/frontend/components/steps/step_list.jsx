import React from 'react';
import StepListItem from './step_list_item';
import { StepForm } from './step_form';

export default function StepsList({
  steps,
  updateStep,
  destroyStep,
  createStep,
  todo,
}) {
  // const todoSteps = steps.filter((step) => step.todo_id == todo.id);

  const stepsItems = steps.map((step, index) => (
    <StepListItem
      key={step.id}
      step={step}
      destroyStep={destroyStep}
      updateStep={updateStep}
    />
  ));

  return (
    <div>
      <h3>Step List goes here!</h3>
      <ul>{stepsItems}</ul>
      <StepForm createStep={createStep} todo_id={todo.id} />
    </div>
  );
}
