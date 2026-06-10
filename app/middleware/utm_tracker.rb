diff --git a/app/middleware/utm_tracker.rb b/app/middleware/utm_tracker.rb
index 0000000..e69de29
+++ b/app/middleware/utm_tracker.rb
class UtmTracker
  def initialize(app)
    @app = app
  end

  def call(env)
    # Capture UTM parameters
    utm_params = extract_utm_params(env)

    # Store UTM parameters in the database
    DirectoryReferral.create(utm_params)

    @app.call(env)
  end

  private

  def extract_utm_params(env)
    # Extract UTM parameters from the request
    # ...
  end
end