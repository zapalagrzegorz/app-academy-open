const API_UTIL = require('./api_util');

class TweetCompose {
  constructor(el) {
    this.$el = el;
    this.$el.on('submit', () => {
      // tweet-compose
    });
  }

  submit() {
    const formData = this.$el.serializeJSON();
    // API_UTIL.createTweet(formData).done(...).fail(...)

    // serializeJSON to build JSON from the form contents and write an APIUtil#createTweet(data) function to submit the form.
  }
}

module.exports = TweetCompose;
