class JobsController < ApplicationController
  before_action :set_job, only: [:show, :update, :take_job,
                                 :rider_complete, :user_complete, :destroy]
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

  # POST show list of jobs close to rider.
  def local_jobs_list_rider
    # lookup all jobs within the range variable
    @jobs = Job.where(taken: false).within(params[:range], :units => :miles, :origin => [params[:rider_lat], params[:rider_long]])
    # return list of jobs.
    render json: @jobs
  end

  # check that user does not have open jobs if so
  # return that job information and set the screen to show
  def check_open_jobs
    if @current_user.account_type == 'rider'
      job = Job.where(rider_id: @current_user.id, rider_complete: false)
    else
      job = Job.where(user_id: @current_user, user_complete: false)
    end
    if job.empty?
      message = { message: false }
      render json: message
    else
      render json: job[0]
    end
  end

  # POST /jobs
  def create
    # set the user id and name for the title by the current user.
    @job = Job.new(user_id: @current_user.id, title: @current_user.name,
                   latitude: params[:latitude], longitude: params[:longitude],
                   taken: false, note: params[:note], user_complete: false,
                   rider_complete: false)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # Patch/put jobs/ID   Rider marks the job complete so he can get another.
  # before action will set the job from the id.
  def job_complete
    if @current_user.account_type === 'rider'
     @job.update(rider_complete: true)
      # we need to start adding in the update to the stats.
    else
      @job.update(user_complete: true)
    end
    render json: @job
  end

  # Patch/put jobs/ID   take a job if it is available.
  # before action will set the job from the id.
  def take_job
    # we check to see if someone beet us to the job
    if @job.taken
      message = { message: 'This job has been taken by another rider.' }
      render json: message
    else
      # looks like we are good to go set the rider location and id and take the job
      @job.taken = true
      @job.update(rider_id: @current_user.id, rider_name: @current_user.name, rider_lat: params[:rider_lat],
                  rider_long: params[:rider_long], taken: true)
      # return the whole job object so we can populate the job map screen.
      render json: @job
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

  # DELETE /jobs/1 cancel an open job before a rider takes it
  def destroy
    unless @job.taken
      @job.update(taken: true, user_complete: true)
    end
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
                                  :latitude, :longitude, :rider_lat,
                                  :rider_long, :range)
    end
end
