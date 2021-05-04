export const stepsByTodoId = ({ steps }, todo_id) => {
  const stepsByTodoId = [];

  Object.keys(steps).forEach((stepId) => {
    const step = steps[stepId];
    if (steps[stepId].todo_id === todo_id) stepsByTodoId.push(step);
  });

  return stepsByTodoId;
};

export const allTodos = (state) => Object.values(state.todos);
export const allSteps = (state) => Object.values(state.steps);
export const allErrors = (state) => state.errors;
