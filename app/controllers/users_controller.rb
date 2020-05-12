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
      if @user.account_type == "rider"
        @user.stat = Stat.new(user_id: @user.id, life_t_distance: 0, life_t_num_jobs: 0, daily_job_num: 0, daily_distance: 0)
      end
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end 

  def reset_password
    user = User.find_by_email(user_params[:email])
    if(!user)
        render json: @user.errors, status: :unprocessable_entity
    end

    rp_token = Devise.token_generator.generate(User, :reset_password_token)

    user.reset_password_token = rp_token[1]
    user.reset_password_sent_at = Time.now.utc

    if(user.save)
      UserMailer.reset_password_email(user, rp_token[0]).deliver_now
     else
      render json: @user.errors, status: :unprocessable_entity
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
      params.require(:user).permit(:email, :password, :name, :image_link, :account_type, :vin_number, :plate_number, :bike_type)
    end
end
