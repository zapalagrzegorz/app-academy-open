import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
import { deleteTodo } from '../../actions/todo_actions';
import { receiveSteps } from '../../actions/steps_actions';

const mapDispatchToProps = (dispatch) => ({
  // receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  receiveSteps: () => dispatch(receiveSteps()),
  deleteTodo: (id) => dispatch(deleteTodo(id)),
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
