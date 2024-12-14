class ChargesController < ApplicationController
  def create
    # Standard Job: prod_ROmJDDrNbd1Qvn
    # Premium Job: prod_ROmKZtmpdV8Flf
    price_id = case params[:plan]
               when 'standard'
                 ENV['STRIPE_STANDARD_PRICE_ID'] # Add this to your .env file once you have it
               when 'premium'
                 ENV['STRIPE_PREMIUM_PRICE_ID'] # Add this to your .env file once you have it
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
        success_url: success_charges_url,
        cancel_url: pricing_url,
        metadata: {
          plan: params[:plan]
        }
      })

      redirect_to session.url, allow_other_host: true
    rescue Stripe::InvalidRequestError => e
      flash[:error] = "There was an error creating your payment session. Please try again or contact support."
      redirect_to pricing_url
    rescue => e
      flash[:error] = "An unexpected error occurred. Please try again or contact support."
      redirect_to pricing_url
    end
  end

  def success
    # Handle successful payment
    flash[:notice] = "Payment successful! Your job posting will be live soon."
    redirect_to root_path
  end
end 