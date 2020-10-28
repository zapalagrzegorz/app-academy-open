const API_UTIL = require('./api_util');

class InfiniteTweets {
  constructor($el) {
    this.$el = $el;
    this.$feedList = $el.find('#feed');
    this.$fetchMoreBtn = this.$el.find('button');
    this.maxCreatedAt = null;
    this.$fetchMoreBtn.on('click', (e) => {
      this.fetchMoreTweets(e);
    });
    this.$el.on('insert-tweet', this.insertTweet.bind(this));
  }

  fetchMoreTweets() {
    this.$fetchMoreBtn.prop('disabled', true);
    API_UTIL.fetchTweets(this.maxCreatedAt)
      .done((tweets) => {
        this.maxCreatedAt = tweets[tweets.length - 1].created_at;
        this.insertTweets(tweets);
        if (tweets.length < 20) {
          this.$fetchMoreBtn.replaceWith('<p>No more tweets!</p>');
        }
      })
      .fail((qXHR, textStatus, errorThrown) => {
        console.error(qXHR, textStatus, errorThrown);
      })
      .always(() => {
        this.$fetchMoreBtn.prop('disabled', false);
      });
  }

  insertTweets(tweets) {
    let tweetsTemplate = '';
    tweets.forEach((tweet) => {
      tweetsTemplate += API_UTIL.buildTweetTemplate(tweet);
    });

    this.$feedList.append(tweetsTemplate);
  }

  insertTweet(e, data) {
    this.$feedList.append(API_UTIL.buildTweetTemplate(data));
    // nie zaciągaj dodanej właśnie publikacji
    if (!this.maxCreatedAt) {
      this.maxCreatedAt = data.created_at;
    }
    // }
  }

  // insertTweet(event, data) {
  //   this.$el.find('ul.tweets').prepend(this.tweetElement(data));
}

module.exports = InfiniteTweets;
