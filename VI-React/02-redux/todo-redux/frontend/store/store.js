import { createStore, applyMiddleware } from 'redux';
import { rootReducer } from '../reducers/root_reducer';
import logger from 'redux-logger';

const addLoggingToDispatch = (store) => (next) => (action) => {
  // Create a variable dispatch, setting it equal to store.dispatch
  console.log(store.getState());
  console.log(action);
  // dispatch(action)
  next(action);
  console.log(store.getState());
};

// Write a second middleware and pass it to applyMiddleware in store.js. Try logging what next is in each of your middlewares. Also, notice when the state is getting updated. How do these middlewares fit in to the Redux cycle?

export const configureStore = (preloadedState = {}) => {
  return createStore(
    rootReducer,
    preloadedState,
    applyMiddleware(addLoggingToDispatch)
    // applyMiddleware()
  );
};
