const messages = {
  sent: [
    {
      to: 'friend@gmail.com',
      subject: 'check my message',
      body: "it's good enough",
    },
    { to: 'person@mail.com', subject: 'zzz', body: 'so booring' },
  ],
  inbox: [
    {
      from: 'grandma@mail.com',
      subject: 'Fwd: Fwd: Fwd: Check this out',
      body: 'Stay at home mom discovers cure for leg cramps. Doctors hate her',
    },
    {
      from: 'person@mail.com',
      subject: 'Questionnaire',
      body: 'Take this free quiz win $1000 dollars',
    },
  ],
};

class Message {
  constructor(from, to, subject, body) {
    this.from = from || '';
    this.to = to || '';
    this.subject = subject || '';
    this.body = body || '';
  }
}

export const MessageStore = {
  // a function that returns the array at messages.inbox
  getInboxMessages() {
    return messages.inbox;
  },
  // : a function that returns the array at messages.sent.
  getSentMessages() {
    return messages.sent;
  },

  messageDraft: new Message(),

  getMessageDraft() {
    return this.messageDraft;
  },
  updateDraftField(field, value) {
    this.messageDraft[field] = value;
  },
  sendDraft() {
    messages.sent.push(this.messageDraft);
    this.messageDraft = new Message();
  },
};
