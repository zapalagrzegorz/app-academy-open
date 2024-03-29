'use strict';

import { Router } from './router';
import { Inbox } from './inbox';
import { Sent } from './sent';
import { Compose } from './compose';

const routes = {
  inbox: Inbox,
  sent: Sent,
  compose: Compose,
};

document.addEventListener('DOMContentLoaded', () => {
  const routerTarget = document.querySelector('.content');
  const router = new Router(routerTarget, routes);

  router.start();

  const basicOperationsBtns = document.querySelectorAll('.sidebar-nav li');

  const setHashLocation = (e) => {
    window.location.hash = e.currentTarget.innerText.toLowerCase();
  };

  basicOperationsBtns.forEach((element) => {
    element.addEventListener('click', setHashLocation);
  });
});
