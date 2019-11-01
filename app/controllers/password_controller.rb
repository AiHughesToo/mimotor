
class PasswordCOntroller < ApplicationController

  def set_new_password
    token_reference = Devise.token_generator.digest(self, :reset_password_token, params.require(:token))
    user = User.find_by_reset_password_token(token_reference)
      p user
    if (user && user.save)
        render json: {success: 'Password Reset'}
      p user
    else
      p "that did not work."
      render json: {errors: 'Email Not Found'}, status: :unprocessable_entity
    end
  end

end