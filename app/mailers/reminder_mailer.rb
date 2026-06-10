class ReminderMailer < ApplicationMailer
  default from: 'no-reply@axentx.com'

  def pending_submission_reminder(maker_email, submission_details)
    @submission_details = submission_details
    mail(to: maker_email, subject: 'Reminder: Your Directory Submission is Still Pending')
  end
end