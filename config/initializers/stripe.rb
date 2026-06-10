Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.completed' do |event|
    PaymentsController.new.webhook(event)
  end
end