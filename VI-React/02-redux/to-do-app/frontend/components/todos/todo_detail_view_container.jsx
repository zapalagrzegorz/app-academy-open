import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
import { destroyTodo } from '../../actions/todo_actions';
import { fetchSteps } from '../../actions/steps_actions';

const mapDispatchToProps = (dispatch) => ({
  fetchSteps: () => dispatch(fetchSteps()),
  destroyTodo: (todo) => dispatch(destroyTodo(todo)),
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
