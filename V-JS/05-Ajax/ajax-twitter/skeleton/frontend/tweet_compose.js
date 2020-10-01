const API_UTIL = require('./api_util');
const MAX_TWEET_CHARS = 140;

class TweetCompose {
  constructor(el) {
    this.$el = el;
    this.$inputs = this.$el.find(':input');
    this.$textArea = this.$el.find('textarea');
    this.$el.on('submit', (e) => {
      this.submit(e);
    });
    this.$textArea.on('input', () => {
      this.countCharsLeft();
    });
    this.countCharsLeft();
  }

  submit(e) {
    e.preventDefault();
    const formData = this.$el.serialize();
    this.$el.find(':input').prop('disabled', true);
    API_UTIL.createTweet(formData)
      .done((tweet) => {
        console.log(JSON.stringify(tweet));
        const tweetsContainerId = this.$el.data('tweetsList');
        const template = this.buildTweetTemplate(tweet);

        $(`#${tweetsContainerId}`).prepend(template);
        this.clearInput();
      })
      .fail((qXHR, textStatus, errorThrown) => {
        console.error(qXHR, textStatus, errorThrown);
      })
      .always(() => {
        const inputs = this.$inputs;
        inputs.each((_, el) => {
          $(el).prop('disabled', false);
        });
      });
  }

  clearInput() {
    this.$inputs.not('[type="submit"], [type="hidden"]').each((_, el) => {
      $(el).val('');
    });
  }

  handleSuccess() {
    this.clearInput();
  }

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
  }

  countCharsLeft() {
    const charsLeft = MAX_TWEET_CHARS - this.$textArea.val().length;
    $('.chars-left').text(charsLeft);
  }
}

module.exports = TweetCompose;
