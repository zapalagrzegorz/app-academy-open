import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
import { destroyTodo } from '../../actions/todo_actions';
import { receiveSteps } from '../../actions/steps_actions';

const mapDispatchToProps = (dispatch) => ({
  // receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  receiveSteps: () => dispatch(receiveSteps()),
  destroyTodo: (todo) => dispatch(destroyTodo(todo)),
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
