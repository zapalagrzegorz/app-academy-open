// import React from 'react';

import { connect } from 'react-redux';
import StepsList from './step_list';
import { stepsByTodoId } from '../../reducers/selectors';
import { receiveStep, deleteStep } from '../../actions/steps_actions';

const mapStateToProps = (state, { todo }) => ({
  steps: stepsByTodoId(state, todo.id),
  // todo_id,?
});

const mapDispatchToProps = (dispatch) => ({
  receiveStep: (step) => dispatch(receiveStep(step)),
  deleteStep: (id) => dispatch(deleteStep(id)),
});

export default connect(mapStateToProps, mapDispatchToProps)(StepsList);
