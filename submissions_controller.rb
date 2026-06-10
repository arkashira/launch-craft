# Handle the upgrade button click
def upgrade
  @submission = Submission.find(params[:id])
  session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    line_items: [{
      name: 'Priority Submission',
      amount: 2900, # $29 in cents
      currency: 'usd',
      quantity: 1
    }],
    success_url: "#{root_url}submissions/#{@submission.id}/upgrade/success",
    cancel_url: "#{root_url}submissions/#{@submission.id}"
  )
  redirect_to session.url, allow_other_host: true
end

# Update submission status and send email confirmation after successful payment
def upgrade_success
  @submission = Submission.find(params[:id])
  @submission.update(status: 'Priority', priority_polling: true)
  # Send email confirmation
  SubmissionMailer.with(submission: @submission).upgrade_confirmation.deliver_now
  redirect_to submission_path(@submission), notice: 'Submission upgraded successfully'
end