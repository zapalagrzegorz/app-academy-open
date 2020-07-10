# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'Admin <admin@musicapp.com>'

  def activate_email(user)
    @user = user
    @activation_token = @user.activation_token
    mail(to: user.email, subject: 'Activate account at Success with Public App')
  end
end
