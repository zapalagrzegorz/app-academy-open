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
    const options = {
      dataType: 'json',
      data: {
        query: queryVal,
        authenticity_token: $('[name="csrf-token"]')[0].content,
      },
    };
    return $.ajax('/users/search', options);
  },

  createTweet: (formData) => {
    const options = Object.assign({
      method: 'POST',
      dataType: 'json',
      data: formData,
    });
    return $.ajax('/tweets', options);
  },

  fetchTweets: (maxCreatedAt) => {
    _commonOptions.data = maxCreatedAt
      ? Object.assign(_commonOptions.data, { max_created_at: maxCreatedAt })
      : _commonOptions.data;

    const methodOptions = { url: '/feed' };
    const options = Object.assign(_commonOptions, methodOptions);
    return $.ajax(options);
  },

  buildTweetTemplate(tweet) {
    let mentions = '';
    let mentionedUsers = '';
    if (tweet.mentions.length) {
      tweet.mentions.forEach((mention) => {
        mentionedUsers += `
        <li>
          <a href="/users/${mention.user.id}">
            ${mention.user.username}
          </a>
        </li>`;
      });
    }

    if (mentionedUsers) {
      mentions = `<ul>${mentionedUsers}</ul>`;
    }

    const template = `
    <li>
      ${tweet.content}
      -- <a href="/users/${tweet.user.id}">${tweet.user.username}</a>
      -- ${tweet.created_at}
      ${mentions}
    </li>`;

    return template;
  },
  debounce: (fn, interval) => {
    // Setup a timer
    let timeout;

    // Return a function to run debounced
    return function () {
      // Setup the arguments
      let args = arguments;

      /* context - this, jest chyba po to, że gdyby w metodzie było odwołanie do this, to jest aby go zachować */
      let context = this;

      // If there's a timer, cancel it
      if (timeout) {
        clearTimeout(timeout);
      }

      // Setup the new requestAnimationFrame()
      timeout = setTimeout(function () {
        fn.apply(context, args);
      }, interval);
    };
  },
};

module.exports = APIUtil;
