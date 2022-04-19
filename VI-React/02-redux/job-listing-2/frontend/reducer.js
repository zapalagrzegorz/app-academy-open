const initialState = {
  city: 'Please Select',
  jobs: [],
};

const reducer = (state = initialState, action) => {
  // const { city, jobs } = action.payload;
  switch (action.type) {
    case 'SWITCH_LOCATION':
      return { ...state, ...action.payload };
    default:
      return state; // remove this and fill out the body of the reducer function
  }
};

export default reducer;
