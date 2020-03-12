
class UserMailer < ApplicationMailer

  def reset_password_email(user, rp_token)
    @user = user
    @rp_token = rp_token
    mail(to: @user.email, subjet: 'test')
  end
end