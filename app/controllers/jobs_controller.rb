class JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_job, only: [:show, :edit, :update, :destroy, :publish, :unpublish, :preview]
  before_action :ensure_job_owner, only: [:edit, :update, :destroy, :preview]
  before_action :ensure_published, only: [:show]
  
  def index
    @jobs = Job.published
  end
  
  def show
    # Only show published jobs to non-owners
    unless @job.user == current_user
      redirect_to root_path, alert: 'Job not found' unless @job.published?
    end
  end
  
  def preview
    # Only job owner can preview unpublished jobs
    render 'show'
  end
  
  def new
    @job = current_user.jobs.build
  end
  
  def create
    @job = current_user.jobs.build(job_params)
    @job.published = false # Ensure job starts as unpublished
    
    if @job.save
      redirect_to pricing_path(job_id: @job.id), notice: 'Please select a payment plan to publish your job listing.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    redirect_to pricing_path(job_id: @job.id), alert: 'Please complete payment to publish your job listing.' unless @job.published?
  end
  
  def update
    if @job.update(job_params)
      redirect_to preview_job_path(@job), notice: 'Job was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully deleted.'
  end
  
  def publish
    unless @job.user == current_user
      redirect_to root_path, alert: 'Unauthorized action'
      return
    end
    
    if @job.paid? # You'll need to add this method to the Job model
      @job.publish!
      redirect_to @job, notice: 'Your job listing is now live!'
    else
      redirect_to pricing_path(job_id: @job.id), alert: 'Please complete payment to publish your job listing.'
    end
  end
  
  def unpublish
    unless @job.user == current_user
      redirect_to root_path, alert: 'Unauthorized action'
      return
    end
    
    @job.unpublish!
    redirect_to @job, notice: 'Job has been unpublished.'
  end

  def pricing
    @job = Job.find(params[:job_id]) if params[:job_id]
  end
  
  private
  
  def set_job
    @job = Job.find(params[:id])
  end

  def ensure_job_owner
    unless @job.user == current_user
      redirect_to root_path, alert: 'Unauthorized action'
    end
  end

  def ensure_published
    unless @job.published? || @job.user == current_user
      redirect_to root_path, alert: 'Job not found'
    end
  end
  
  def job_params
    params.require(:job).permit(:title, :description, :company_name, 
                              :company_website, :company_email, :location,
                              :job_type, :salary_range, :category, :education_level)
  end
end
