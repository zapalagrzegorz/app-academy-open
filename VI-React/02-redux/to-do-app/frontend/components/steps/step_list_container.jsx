// import React from 'react';

import { connect } from 'react-redux';
import StepsList from './step_list';
import { stepsByTodoId } from '../../reducers/selectors';
import {
  updateStep,
  destroyStep,
  createStep,
} from '../../actions/steps_actions';

const mapStateToProps = (state, { todo }) => ({
  steps: stepsByTodoId(state, todo.id),
});

const mapDispatchToProps = (dispatch) => ({
  createStep: (step) => dispatch(createStep(step)),
  updateStep: (step) => dispatch(updateStep(step)),
  destroyStep: (id) => dispatch(destroyStep(id)),
});

export default connect(mapStateToProps, mapDispatchToProps)(StepsList);
