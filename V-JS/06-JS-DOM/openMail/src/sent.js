export const Sent = {
  render() {
    const list = document.createElement('ul');
    list.classList.add('messages');
    list.innerHTML = 'sent messages';
    return list;
  },
};
