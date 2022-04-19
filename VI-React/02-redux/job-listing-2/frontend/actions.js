export function selectLocation(city, jobs) {
  return {
    type: 'SWITCH_LOCATION',
    payload: {
      city,
      jobs,
    },
  };
}
