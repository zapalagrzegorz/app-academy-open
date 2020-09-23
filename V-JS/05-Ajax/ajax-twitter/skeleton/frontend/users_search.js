const APIUtil = require('./api_util');

class UsersSearch {
  constructor(el) {
    this.$el = el;
    this.$usersList = el.find('ul.users');
    this.$input = el.find('input');
    this.$input.on('input', (e) => this.onInput(e));
  }

  // render(){}

  onInput(e) {
    const value = e.currentTarget.value;
    const $XHR = APIUtil.searchUsers(value);

    const successCb = (resp) => {
      resp.forEach((user) => {
        const userItem = $(`
          <li><a href="/users/${user.id}">${user.username}</a></li>
          <button type="button" class="follow-toggle" 
            data-user-id="${user.id}" 
            data-initial-follow-state="<%= current_user.follows?(user) %>"></button>
        `);

        this.$usersList.append(userItem);
      });
      // this.render();
    };

    $XHR.done(successCb).fail((err) => console.log(err));
  }
}

module.exports = UsersSearch;
