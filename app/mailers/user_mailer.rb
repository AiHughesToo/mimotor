
class UserMailer < ApplicationMailer

  def reset_password_email(user, prToken)
    @user = user
    @prToken = prToken
    mail(to: @user.email, subjet: 'test')
  end
end