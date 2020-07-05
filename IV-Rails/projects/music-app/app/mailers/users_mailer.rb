# frozen_string_literal: true

class UsersMailer < ApplicationMailer
  default from: 'Admin <admin@musicapp.com>'

  def activate_email(user)
    @user = user
    mail(to: @user.email, subject: 'Activate account at Music App')
  end
end
