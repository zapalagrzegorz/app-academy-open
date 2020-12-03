import { MessageStore } from './message-store';

export const Sent = {
  render() {
    const list = document.createElement('ul');
    list.classList.add('messages');

    const messages = MessageStore.getSentMessages().map(this.renderMessage);
    list.append(...messages);
    return list;
  },
  renderMessage(message) {
    const { to, subject, body } = message;
    const li = document.createElement('li');
    li.classList.add('message');
    li.innerHTML = `<span class="to">To: ${to}</span>
    <span class="subject">subject: ${subject}</span>
    <span class="body">${body}</span>
    `;
    return li;
  },
};
