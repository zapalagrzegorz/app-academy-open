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
    

    if(this.followState == 'unfollowing' || this.followState == 'following'){
      // this.$el.get(0).disabled = true;
      this.$el.prop('disabled', true);
    } else{
      this.$el.text(this.followState ? 'Unfollow' : 'Follow');
      // this.$el.get(0).disabled = false;
      this.$el.prop('disabled', false);
    }
  }

  // Prevent the default action.
  // Make a $.ajax request to POST /users/:id/follow if we are not following the user (check followState), else, it should make a DELETE request.
  // On success of the POST/DELETE, we should toggle the followState and re-render.
  handleClick(e) {
    e.preventDefault();
    this.followState = this.followState ? 'unfollowing' : 'following';
    this.render();
    
    const successCb = () => {
      this.followState = (this.followState == 'unfollowing') ? false : true;
      this.render();
    };
    const ajaxCall = (this.followState == 'unfollowing')
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
