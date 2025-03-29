class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job
  
  def create
    @application = @job.applications.build(application_params)
    @application.user = current_user
    
    if @application.save
      redirect_to @job, notice: 'Your application was submitted successfully!'
    else
      redirect_to @job, alert: 'There was an error submitting your application.'
    end
  end
  
  private
  
  def set_job
    @job = Job.find(params[:job_id])
  end
  
  def application_params
    params.require(:application).permit(:cover_letter)
  end
end 