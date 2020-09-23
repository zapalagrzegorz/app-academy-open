const _commonOptions = {
  dataType: 'json',
  data: { authenticity_token: $('[name="csrf-token"]')[0].content },
};

const APIUtil = {
  followUser: (id) => {
    const options = Object.assign({ method: 'POST' }, _commonOptions);
    return $.ajax(`/users/${id}/follow`, options);
  },

  unfollowUser: (id) => {
    const options = Object.assign({ method: 'DELETE' }, _commonOptions);
    return $.ajax(`/users/${id}/follow`, options);
  },

  searchUsers: (queryVal) => {
    const options = Object.assign({
      dataType: 'json',
      data: {
        query: queryVal,
        authenticity_token: $('[name="csrf-token"]')[0].content,
      },
    });
    return $.ajax('/users/search', options);
  },
};

module.exports = APIUtil;
