class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:create]
  before_action :ensure_job_owner, only: [:create]

  def create
    # Debug output
    Rails.logger.info "STRIPE_SECRET_KEY present: #{ENV['STRIPE_SECRET_KEY'].present?}"
    Rails.logger.info "STRIPE_PUBLISHABLE_KEY present: #{ENV['STRIPE_PUBLISHABLE_KEY'].present?}"
    Rails.logger.info "STRIPE_STANDARD_PRICE_ID: #{ENV['STRIPE_STANDARD_PRICE_ID']}"
    Rails.logger.info "STRIPE_PREMIUM_PRICE_ID: #{ENV['STRIPE_PREMIUM_PRICE_ID']}"
    Rails.logger.info "Request format: #{request.format}"
    Rails.logger.info "Request headers: #{request.headers['HTTP_ACCEPT']}"

    # Explicitly set Stripe API key
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    price_id = case params[:plan]
               when 'standard'
                 ENV['STRIPE_STANDARD_PRICE_ID']
               when 'premium'
                 ENV['STRIPE_PREMIUM_PRICE_ID']
               else
                 raise "Invalid plan selected"
               end

    begin
      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price: price_id,
          quantity: 1,
        }],
        mode: 'payment',
        success_url: "#{request.base_url}/charges/success?job_id=#{@job.id}",
        cancel_url: "#{request.base_url}/pricing?job_id=#{@job.id}",
        metadata: {
          plan: params[:plan],
          job_id: @job.id
        },
        client_reference_id: @job.id.to_s
      })

      Rails.logger.info "Created Stripe session: #{session.id}"
      Rails.logger.info "Redirecting to: #{session.url}"

      redirect_to session.url, allow_other_host: true, status: :see_other
    rescue => e
      Rails.logger.error "Stripe error: #{e.message}"
      flash[:error] = "Payment setup failed: #{e.message}"
      redirect_to pricing_url(job_id: @job.id), status: :see_other
    end
  end

  def success
    if params[:job_id].present?
      job = Job.find_by(id: params[:job_id])
      if job && job.user == current_user
        job.mark_as_paid!
        job.publish!
        flash[:notice] = "Payment successful! Your job posting is now live."
        redirect_to job_path(job)
      else
        flash[:error] = "Could not find your job listing."
        redirect_to dashboard_path
      end
    else
      flash[:notice] = "Payment successful!"
      redirect_to dashboard_path
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def ensure_job_owner
    unless @job.user == current_user
      flash[:error] = "Unauthorized action"
      redirect_to root_path
    end
  end
end 