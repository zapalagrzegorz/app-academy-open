const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');

$(() => {
  $('button.follow-toggle').each((_, el) => {
    new FollowToggle($(el));
  });

  $('nav.users-search').each((_, el) => {
    new UsersSearch($(el));
  });

});
