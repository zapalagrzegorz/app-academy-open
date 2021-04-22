import React from 'react';
import StepListItem from './step_list_item';
import { StepForm } from './step_form';

export default function StepsList({ steps, receiveStep, deleteStep, todo }) {
  // const todoSteps = steps.filter((step) => step.todo_id == todo.id);

  const stepsItems = steps.map((item, index) => (
    <StepListItem
      key={item.id}
      item={item}
      deleteStep={deleteStep}
      receiveStep={receiveStep}
      todo_id={todo.id}
    />
  ));

  return (
    <div>
      <h3>Step List goes here!</h3>
      <ul>{stepsItems}</ul>
      <StepForm receiveStep={receiveStep} todo_id={todo.id} />
    </div>
  );
}
