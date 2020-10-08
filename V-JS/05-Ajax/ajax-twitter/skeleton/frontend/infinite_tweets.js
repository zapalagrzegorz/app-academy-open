const API_UTIL = require('./api_util');

class InfiniteTweets {
  constructor($el) {
    this.$container = $el;
    this.$feedList = $el.find('#feed');
    this.$fetchMoreBtn = this.$container.find('button');
    this.$fetchMoreBtn.on('click', (e) => {
      this.fetchMoreTweets(e);
    });
  }

  fetchMoreTweets() {
    this.$el.find('button').prop('disabled', true);
    API_UTIL.fetchTweets()
      .done((tweets) => {
        console.log(tweets);
        // #insertTweets
        this.insertTweets(tweets);
      })
      .fail((qXHR, textStatus, errorThrown) => {
        console.error(qXHR, textStatus, errorThrown);
      })
      .always(() => {
        this.$el.find('button').prop('disabled', true);
      });
  }

  insertTweets(tweets) {
    let tweetsTemplate = '';
    tweets.forEach((tweet) => {
      tweetsTemplate += API_UTIL.buildTweetTemplate(tweet);
    });

    this.$feedList.append(tweetsTemplate);
  }
}

module.exports = InfiniteTweets;
