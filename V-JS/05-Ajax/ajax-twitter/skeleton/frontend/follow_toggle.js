const API_UTIL = require('./api_util');

class FollowToggle {
  constructor($el) {
    this.$el = $el;
    this.id = $el.data('userId');
    this.followState = $el.data('initialFollowState');
    this.render();
    // closure!
    this.$el.on('click', (e) => this.handleClick(e));
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
