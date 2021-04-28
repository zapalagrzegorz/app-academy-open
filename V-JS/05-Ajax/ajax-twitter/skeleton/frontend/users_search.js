const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor(el) {
    this.$el = el;
    this.currentUserId = $('[data-current-user-id]').data('currentUserId');
    this.$usersList = el.find('ul.users');
    this.$input = el.find('input');
    this.onInput = APIUtil.debounce(this.onInput, 500);
    this.$input.on('input', (e) => this.onInput(e));
  }

  onInput(e) {
    const value = e.currentTarget.value;
    const $XHR = APIUtil.searchUsers(value);
    this.$usersList.empty();

    const successCb = (resp) => {
      resp.forEach((user) => {
        this.currentUserId;
        user.id;
        const userItem = `
          <li><a href="/users/${user.id}">${user.username}</a><br/>
          ${
            this.currentUserId !== user.id
              ? `
            <button type="button" class="follow-toggle" 
              data-user-id="${user.id}" 
              data-initial-follow-state="${user.followed}"></button>`
              : ''
          }</li>`;

        this.$usersList.append(userItem);

        const followToggleBtnOptions = {
          userId: user.id,
          initialFollowState: user.followed,
        };

        this.$el.find('.follow-toggle').each((_, button) => {
          new FollowToggle(button, followToggleBtnOptions);
        });
      });
    };

    $XHR.done(successCb).fail((err) => console.log(err));
  }
}

module.exports = UsersSearch;
