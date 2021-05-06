import * as todoAPIUtil from '../util/todo_api_util';
import * as errorActions from '../actions/errors_actions';

export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
export const DELETE_TODO = 'DELETE_TODO';

export const receiveTodos = (todos) => ({
  type: RECEIVE_TODOS,
  todos,
});

export const receiveTodo = (todo) => ({
  type: RECEIVE_TODO,
  todo,
});

export const deleteTodo = (id) => ({
  type: DELETE_TODO,
  id,
});

/**
 * Thunk action creator
 * returns function that takes dispatch
 *
 * Wraps synchrous actions with asynchrous
 * @returns function(dispatch)
 */
export const fetchTodos = () => (dispatch) => {
  return todoAPIUtil
    .getTodos()
    .then((todos) => {
      dispatch(receiveTodos(todos));
    })
    .fail((error) => {
      dispatch(errorActions.receiveErrors(error));
    });
};

export const createTodo = (todo) => (dispatch) => {
  // return
  let promise = todoAPIUtil.createTodo(todo);

  return promise.then(
    (newTodo) => {
      dispatch(receiveTodo(newTodo));
      dispatch(errorActions.clearErrors());
    },
    (error) => dispatch(errorActions.receiveErrors(error.responseJSON))
  );
};

// export const createTodo = (todo) => (dispatch) =>
//   TodoAPIUtil.createTodo(todo).then(
//     (todo) => {
//       dispatch(receiveTodo(todo));
//       dispatch(clearErrors());
//     },
//     (err) => dispatch(receiveErrors(err.responseJSON))
//   );

export const updateTodo = (todo) => (dispatch) => {
  return todoAPIUtil
    .updateTodo(todo)
    .then((updatedTodo) => {
      dispatch(receiveTodo(updatedTodo));
    })
    .fail((error) => {
      dispatch(errorActions.receiveErrors(error.responseJSON));
    });
};

export const destroyTodo = (todo) => (dispatch) => {
  return todoAPIUtil
    .destroyTodo(todo)
    .then((deletedTodo) => {
      dispatch(deleteTodo(deletedTodo.id));
    })
    .fail((error) => {
      dispatch(errorActions.receiveErrors(error.responseJSON));
    });
};
