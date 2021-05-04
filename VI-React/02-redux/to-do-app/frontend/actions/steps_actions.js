export const RECEIVE_STEPS = 'RECEIVE_STEPS';
export const RECEIVE_STEP = 'RECEIVE_STEP';
export const DELETE_STEP = 'DELETE_STEP';

export const receiveSteps = (steps) => ({
  type: RECEIVE_STEPS,
  steps,
});

export const receiveStep = (step) => ({
  type: RECEIVE_STEP,
  step,
});

export const deleteStep = (id) => ({
  type: DELETE_STEP,
  id,
});
