import { MessageStore } from './message-store';

export const Inbox = {
  render() {
    const list = document.createElement('ul');
    const messages = MessageStore.getInboxMessages().map(this.renderMessage);

    list.classList.add('messages');
    list.append(...messages);

    return list;
  },

  renderMessage(message) {
    const { from, subject, body } = message;
    const li = document.createElement('li');
    li.classList.add('message');
    li.innerHTML = `<span class="from">FROM: ${from}</span>
    <span class="subject">subject: ${subject}</span>
    <span class="body">${body}</span>
    `;
    return li;
  },
};
