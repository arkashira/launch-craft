class PaymentConfirmationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_email
    @submission = params[:submission]
    mail(to: @submission.user.email, subject: 'Payment Confirmation')
  end
end