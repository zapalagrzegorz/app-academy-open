const API_UTIL = require('./api_util');
const MAX_TWEET_CHARS = 140;

class TweetCompose {
  constructor(el) {
    this.$el = el;
    this.$textArea = this.$el.find('textarea');
    this.users = this.setUsers();
    this.mentionedUsersContainer = this.$el.find('.mentioned-users');
    this.$el.on('submit', (e) => {
      this.submit(e);
    });
    this.$el.on('click', '.remove-mentioned-user', (e) => {
      this.removeMention(e);
    });
    this.$textArea.on('input', () => {
      this.countCharsLeft();
    });
    this.$el.find('#addMention').on('click', () => {
      this.addMention();
    });
    this.countCharsLeft();
  }

  submit(e) {
    e.preventDefault();
    const $inputs = this.$el.find(':input');
    const formData = this.$el.serialize();
    this.$el.find(':input').prop('disabled', true);
    API_UTIL.createTweet(formData)
      .done((tweet) => {
        console.log(JSON.stringify(tweet));
        const tweetsContainerId = this.$el.data('tweetsList');
        const template = API_UTIL.buildTweetTemplate(tweet);

        $(`#${tweetsContainerId}`).prepend(template);
        this.clearInput();
      })
      .fail((qXHR, textStatus, errorThrown) => {
        console.error(qXHR, textStatus, errorThrown);
      })
      .always(() => {
        $inputs.each((_, el) => {
          $(el).prop('disabled', false);
        });
      });
  }

  clearInput() {
    this.$textArea.val('');

    this.countCharsLeft();
  }

  handleSuccess() {
    this.clearInput();
  }

  countCharsLeft() {
    const charsLeft = MAX_TWEET_CHARS - this.$textArea.val().length;
    $('.chars-left').text(charsLeft);
  }

  setUsers() {
    const rawUsers = this.$el.find('.mentioned-users');
    const usersInvalidJSON = rawUsers.get(0).dataset.users.split('');
    usersInvalidJSON.splice(usersInvalidJSON.lastIndexOf(','), 1);
    const validUsers = usersInvalidJSON.join('');
    return JSON.parse(validUsers);
  }

  addMention() {
    const usersTemplate = this.users.map(
      (user) => ` <option value="${user.id}">${user.username}</option>`
    );

    const template = `
    <li>
      <button class="remove-mentioned-user">X</button>
      <select name="tweet[mentioned_user_ids][]">
        ${usersTemplate}
      </select>
    </li>`;

    this.mentionedUsersContainer.append(template);
  }

  removeMention(e) {
    e.currentTarget.parentElement.remove();
  }
}

module.exports = TweetCompose;
