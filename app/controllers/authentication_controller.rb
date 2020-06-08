class AuthenticationController < ApplicationController
  # skip_before_action :authenticate_token!

  def create
    if (user = User.find_by(email: params[:email])).nil?
      render json: { errors: 'User not Found' }, status: :unauthorized
    elsif user.valid_password? params[:password]
      object = {user_type: user.account_type, user_name: user.name, user_id: user.id, token: JsonWebToken.encode(sub: user.id) }
      render json: object
    else
      render json: { errors: 'unauthorised' }, status: :unauthorized
    end
  end

end