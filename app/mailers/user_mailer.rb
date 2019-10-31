
class UserMailer < ApplicationMailer

  def password_reset_email(user)
    console.log(user)
    @user = user
    mail(to: @user.email, subjet: 'test')
  end
end