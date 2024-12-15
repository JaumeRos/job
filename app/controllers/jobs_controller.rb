class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :publish, :unpublish]
  
  def index
    @jobs = Job.published.order(created_at: :desc)
    @jobs = @jobs.page(params[:page]).per(25) if defined?(Kaminari)
  end
  
  def show
  end
  
  def new
    @job = current_user.jobs.build
  end
  
  def create
    @job = current_user.jobs.build(job_params)
    
    if @job.save
      if params[:commit] == "Preview Listing"
        redirect_to @job, notice: 'Job was successfully created. Please review your listing.'
      else
        redirect_to pricing_path, notice: 'Job was created. Please select a payment plan to publish.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully deleted.'
  end
  
  def publish
    @job.publish!
    redirect_to @job, notice: 'Job has been published.'
  end
  
  def unpublish
    @job.unpublish!
    redirect_to @job, notice: 'Job has been unpublished.'
  end
  
  private
  
  def set_job
    @job = Job.find(params[:id])
  end
  
  def job_params
    params.require(:job).permit(:title, :description, :company_name, 
                              :company_website, :company_email, :location,
                              :job_type, :salary_range)
  end
end
