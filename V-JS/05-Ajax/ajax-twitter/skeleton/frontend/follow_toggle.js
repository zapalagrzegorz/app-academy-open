const API_UTIL = require('./api_util');

class FollowToggle {
  constructor(el, options) {
    this.$el = $(el);
    this.id = this.$el.data('userId') || options?.userId;
    this.followState =
      this.$el.data().initialFollowState || options?.initialFollowState;
    // closure!
    this.$el.on('click', (e) => this.handleClick(e));
    this.render();
  }

  render() {
    if (this.followState == 'unfollowing' || this.followState == 'following') {
      this.$el.prop('disabled', true);
    } else {
      this.$el.text(this.followState ? 'Unfollow' : 'Follow');
      this.$el.prop('disabled', false);
    }
  }

  // Prevent the default action.
  handleClick(e) {
    e.preventDefault();
    this.followState = this.followState ? 'unfollowing' : 'following';
    this.render();

    const successCb = () => {
      this.followState = this.followState == 'unfollowing' ? false : true;
      this.render();
    };
    const ajaxCall =
      this.followState == 'unfollowing'
        ? API_UTIL.unfollowUser(this.id)
        : API_UTIL.followUser(this.id);

    ajaxCall
      .done(successCb)
      .fail((jqXHR, textStatus, errorThrown) =>
        console.log([jqXHR, textStatus, errorThrown])
      );
  }
}

module.exports = FollowToggle;
