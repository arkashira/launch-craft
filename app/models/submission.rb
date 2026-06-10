class Submission < ApplicationRecord
  validates :status, presence: true
  validates :priority_flag, inclusion: { in: [true, false] }
  validates :payment_id, presence: true, if: :priority?

  def priority?
    status == 'Priority'
  end
end