import { MessageStore } from './message-store';

export const Compose = {
  render() {
    const formContainer = document.createElement('div');
    formContainer.classList.add('new-message');
    formContainer.innerHTML = this.renderForm();
    formContainer.addEventListener('input', function (e) {
      const formInput = e.target.name;
      const formInputValue = e.target.value;
      MessageStore.updateDraftField(formInput, formInputValue);
    });

    formContainer.addEventListener('submit', function (e) {
      e.preventDefault();
      MessageStore.sendDraft();
      window.location.hash = 'inbox';
    });
    return formContainer;
  },

  renderForm() {
    const messageDraft = MessageStore.getMessageDraft();

    return `
      <p class="new-message-header"> New Message</p>
      <form class="compose-form">
        <ul>
          <li>
          <label>To:
            <input placeholder="Recipient" name="to" type="text" value="${messageDraft.to}">
          </label>
          </li>
          <li>
            <label>
              Subject:
              <input placeholder="Subject" name="subject" type="text" value="${messageDraft.subject}">
            </label>
          </li>
          <li>
            <p><label for="body">Body:</label></p>
            <textarea id="boyd" name="body" rows="20">${messageDraft.body}</textarea>
          </li>
          <li>
            <button type="submit" class="btn btn-primary submit-message">Send</button>
          </li>
        </ul>
      </form>`;
  },
};
