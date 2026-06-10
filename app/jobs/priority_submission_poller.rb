class PrioritySubmissionPoller < ApplicationJob
  queue_as :default

  def perform(*args)
    Submission.where(status: 'Priority').each do |submission|
      # Perform necessary actions for priority submissions
      # ...
    end
    PrioritySubmissionPoller.set(wait: 6.hours).perform_later
  end
end