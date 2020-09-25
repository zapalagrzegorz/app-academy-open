const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor(el) {
    this.$el = el;
    this.$usersList = el.find('ul.users');
    this.$input = el.find('input');
    this.onInput = APIUtil.debounce(this.onInput, 500);
    this.$input.on('input', (e) => this.onInput(e));
  }

  // render(){}

  onInput(e) {
    const value = e.currentTarget.value;
    const $XHR = APIUtil.searchUsers(value);
    this.$usersList.empty();

    const successCb = (resp) => {
      resp.forEach((user) => {
        const userItem = $(`
          <li><a href="/users/${user.id}">${user.username}</a></li>
          <button type="button" class="follow-toggle" 
            data-user-id="${user.id}" 
            data-initial-follow-state="${user.followed}"></button>
        `);

        this.$usersList.append(userItem);
      });

      this.$el.find('.follow-toggle').each((_, el) => {
        new FollowToggle($(el));
      });
    };

    $XHR.done(successCb).fail((err) => console.log(err));
  }
}

module.exports = UsersSearch;
