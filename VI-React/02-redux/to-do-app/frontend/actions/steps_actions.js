import * as stepsApiUtil from '../util/steps_api_util';
import * as errorActions from '../actions/errors_actions';

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

/**
 * Thunk action creator
 * returns function that takes dispatch
 *
 * Wraps synchrous actions with asynchrous
 * @returns function(dispatch)
 */
export const fetchSteps = () => (dispatch) => {
  return stepsApiUtil
    .getSteps()
    .then((steps) => {
      dispatch(receiveSteps(steps));
    })
    .fail((errors) => {
      dispatch(errorActions.receiveErrors(errors.responseJSON));
    });
};

export const createStep = (step) => (dispatch) => {
  let promise = stepsApiUtil.createStep(step);

  return promise.then(
    (newStep) => {
      dispatch(receiveStep(newStep));
      dispatch(errorActions.clearErrors());
    },
    (errors) => dispatch(errorActions.receiveErrors(errors.responseJSON))
  );
};

export const updateStep = (step) => (dispatch) => {
  return stepsApiUtil
    .updateStep(step)
    .then((updatedStep) => {
      dispatch(receiveStep(updatedStep));
    })
    .fail((error) => {
      dispatch(errorActions.receiveErrors(error.responseJSON));
    });
};

export const destroyStep = (step) => (dispatch) => {
  let promise = stepsApiUtil.destroyStep(step);

  return promise
    .then((deletedStep) => {
      dispatch(deleteStep(deletedStep.id));
    })
    .fail((errors) => {
      dispatch(errorActions.receiveErrors(errors.responseJSON));
    });

  // return;
};
