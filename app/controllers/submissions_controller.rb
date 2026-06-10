class SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      @submission.process_submission # Call the public method
      redirect_to @submission, notice: 'Submission was successfully created.'
    else
      render :new
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:product_id, :directory_id)
  end
end