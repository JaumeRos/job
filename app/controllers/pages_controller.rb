class PagesController < ApplicationController
  def home
    @recent_jobs = Job.published.recent.limit(3)
  end

  def pricing
  end

  def dashboard
    @jobs = current_user.jobs.order(created_at: :desc) if user_signed_in?
  end

  def privacy_policy
  end

  def terms
  end

  def about
  end

  def contact
  end

  def careers
  end
end
