import { SET_LOADING, SET_LOCATION } from './actions';

const initialState = {
  city: 'Please Select',
  jobs: [],
  loading: false,
};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case SET_LOCATION:
      return {
        ...state,
        city: action.city,
        jobs: action.payload,
        loading: false,
      };
    case SET_LOADING:
      return { ...state, loading: action.isLoading };
    default:
      return state;
  }
};

export default reducer;
