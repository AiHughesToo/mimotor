class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :destroy]
  before_action :authenticate_token!

  # GET /jobs
  def index
    @jobs = Job.all

    render json: @jobs
  end

  # GET /jobs/1
  def show
    render json: @job
  end

  # POST /jobs
  def create
    # set the user id and name for the title by the current user.
    @job = Job.new(user_id: @current_user.id, title: @current_user.name,
                   lat: params[:lat], long: params[:long], note: params[:note], user_complete: false)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:title, :note, :taken, :user_complete,
                                  :rider_complete, :user_id, :rider_id,
                                  :lat, :long, :rider_lat, :rider_long)
    end
end
