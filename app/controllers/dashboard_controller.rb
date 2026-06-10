diff --git a/app/controllers/dashboard_controller.rb b/app/controllers/dashboard_controller.rb
index 0000000..e69de29
+++ b/app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_product_owner!

  def index
    # Display visitor counts for each connected directory
    @directory_referrals = DirectoryReferral.all

    # Add CSV export option
    respond_to do |format|
      format.html
      format.csv { send_data @directory_referrals.to_csv }
    end
  end

  private

  def authenticate_product_owner!
    # Restrict access to the dashboard to the product owner
    # ...
  end
end