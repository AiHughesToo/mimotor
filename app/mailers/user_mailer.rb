
class UserMailer < ApplicationMailer

  def password_reset_email(user)

    @user = user
    mail(to: @user.email, subjet: 'test')
  end
end