# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'admin@99cats.com'

  def welcome_email(user)
    @user = user
    email = @user.username.to_s + '@gmail.com'
    target = %("#{@user.username}" <#{email}>)
    # target = "#{@user.username} <#{email}>"

    @url = '99cats.com/session/new'

    mail(to: target, subject: 'Thank you for staying with 99Cats')
  end
end
