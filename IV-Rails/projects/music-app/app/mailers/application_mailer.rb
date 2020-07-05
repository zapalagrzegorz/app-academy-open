# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'admin@musicapp.com'
  layout 'mailer'
end
