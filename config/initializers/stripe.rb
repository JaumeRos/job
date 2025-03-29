# Log the environment variables for debugging
Rails.logger.info "Loading Stripe configuration..."
Rails.logger.info "STRIPE_PUBLISHABLE_KEY present: #{ENV['STRIPE_PUBLISHABLE_KEY'].present?}"
Rails.logger.info "STRIPE_SECRET_KEY present: #{ENV['STRIPE_SECRET_KEY'].present?}"

# Configure Stripe
Stripe.api_key = ENV['STRIPE_SECRET_KEY']

# Make publishable key available to views
Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key: ENV['STRIPE_SECRET_KEY']
}

# Verify Stripe is configured
begin
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  Rails.logger.info "Stripe configured successfully!"
rescue => e
  Rails.logger.error "Failed to configure Stripe: #{e.message}"
  raise "Stripe configuration failed. Please check your environment variables."
end 