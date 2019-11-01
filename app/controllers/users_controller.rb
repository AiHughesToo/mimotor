class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_token!, except: [:create, :reset_password]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def reset_password
    user = User.find_by_email(user_params[:email])
    rp_token = Devise.token_generator.generate(User, :reset_password_token)
    p rp_token
    p rp_token[0]
    decoded_token = Devise.token_generator.digest(self, :reset_password_token, rp_token[0])
    p decoded_token

    user.reset_password_token = rp_Token[1]
    user.reset_password_sent_at = Time.now.utc

    if(user.save)
      UserMailer.reset_password_email(user, rp_token[0]).deliver_now
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :name, :image_link, :account_type)
    end
end
