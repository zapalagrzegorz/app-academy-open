// Make a new file frontend/middleware/thunk.js. From this, export a single middleware function. This function should check the type of each incoming action and see if it is of type function. If so, return action(dispatch, getState). If not, return next(action). Refer to the Middleware reading and Thunk readings if you need more guidance.
export const middleware = (store) => (next) => (action) => {
  // side effects, if any
  if (typeof action == 'function') {
    return action(dispatch, store.getState());
  }
  return next(action);
};
