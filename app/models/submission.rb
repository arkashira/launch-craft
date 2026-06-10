class Submission < ApplicationRecord
  belongs_to :product
  belongs_to :directory

  enum status: { pending: 0, processing: 1, completed: 2, failed: 3 }

  # Make process_submission public
  def process_submission
    # ... existing logic ...
  end

  def status_name
    statuses.key(status)
  end

  def error_message
    read_attribute(:error)
  end
end