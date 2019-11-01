
class PasswordController < ApplicationController

  def set_new_password
    token_reference = Devise.token_generator.digest(self, :reset_password_token, params.require(:token))
    p params[:token]
    user = User.find_by_reset_password_token(token_reference)
      p user
    if (user)
      user.password = params[:password]
      user.reset_password_token = nil
      user.reset_password_sent_at = nil
      if (user.save)
        render json: {success: 'Password Reset'}
      else
        render json: {errors: 'Email Not Found'}, status: :unprocessable_entity
      end
    else
      render json: {errors: 'Email Not Found'}, status: :unprocessable_entity
    end
  end

end