export const Inbox = {
  render() {
    const list = document.createElement('ul');
    list.classList.add('messages');
    list.innerHTML = 'inbox messages';
    return list;
  },
};
