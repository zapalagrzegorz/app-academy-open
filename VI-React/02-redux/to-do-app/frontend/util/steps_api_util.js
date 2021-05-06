export const getSteps = () => {
  return $.ajax({
    method: 'GET',
    url: '/api/steps',
  });
};

export const createStep = (step) => {
  return $.ajax({
    method: 'POST',
    url: '/api/steps',
    data: {
      step: { ...step },
    },
  });
};

export const updateStep = (step) => {
  return $.ajax({
    method: 'PATCH',
    url: `/api/steps/${step.id}`,
    data: {
      step: { ...step },
      //
    },
  });
};

export const destroyStep = (step) => {
  let promise = $.ajax({
    method: 'DELETE',
    url: `/api/steps/${step.id}`,
  });

  return promise;
};
