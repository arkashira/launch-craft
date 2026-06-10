# tests/middleware/utm_tracker_test.rb
require 'test_helper'

class UtmTrackerTest < Test::Unit::TestCase
  def setup
    @directory_referral = DirectoryReferral.new(utm_params: { source: 'google', medium: 'social' })
    @utm_tracker = UtmTracker.new(directory_referral: @directory_referral)
  end

  test 'captures UTM parameters' do
    @utm_tracker.capture_utm_params
    assert_equal @directory_referral.utm_params, { source: 'google', medium: 'social' }
  end

  test 'stores UTM parameters in database' do
    @utm_tracker.capture_utm_params
    assert_equal @directory_referral.utm_params, { source: 'google', medium: 'social' }
    assert_equal @directory_referral.save.to_sql, "INSERT INTO directory_referrals (utm_params) VALUES ('{\"source\":\"google\",\"medium\":\"social\"}')"
  end
end

# tests/dashboard_test.rb
require 'test_helper'

class DashboardTest < Test::Unit::TestCase
  def setup
    @directory_referral = DirectoryReferral.new(utm_params: { source: 'google', medium: 'social' })
    @utm_tracker = UtmTracker.new(directory_referral: @directory_referral)
    @dashboard = Dashboard.new(utm_tracker: @utm_tracker)
  end

  test 'displays visitor counts for each connected directory' do
    @dashboard.display_visitor_counts
    assert_equal 1, @dashboard.visitor_counts[@directory_referral.id]
  end

  test 'updates visitor counts daily correctly' do
    Timecop.freeze do
      @dashboard.update_visitor_counts
      assert_equal 1, @dashboard.visitor_counts[@directory_referral.id]
      Timecop.return
    end
  end
end

# tests/job_test.rb
require 'test_helper'

class UpdateVisitorCountsJobTest < Test::Unit::TestCase
  def setup
    @directory_referral = DirectoryReferral.new(utm_params: { source: 'google', medium: 'social' })
    @utm_tracker = UtmTracker.new(directory_referral: @directory_referral)
    @dashboard = Dashboard.new(utm_tracker: @utm_tracker)
  end

  test 'updates visitor counts daily correctly' do
    @dashboard.update_visitor_counts
    assert_equal 1, @dashboard.visitor_counts[@directory_referral.id]
  end
end

# tests/export_test.rb
require 'test_helper'

class ExportVisitorCountsTest < Test::Unit::TestCase
  def setup
    @directory_referral = DirectoryReferral.new(utm_params: { source: 'google', medium: 'social' })
    @utm_tracker = UtmTracker.new(directory_referral: @directory_referral)
    @dashboard = Dashboard.new(utm_tracker: @utm_tracker)
  end

  test 'exports visitor counts correctly' do
    csv = @dashboard.export_visitor_counts
    assert_equal "utm_params,visitor_count\n{\"source\":\"google\",\"medium\":\"social\"},1", csv
  end
end

# tests/access_control_test.rb
require 'test_helper'

class AccessControlTest < Test::Unit::TestCase
  def setup
    @product_owner = User.new(email: 'product_owner@example.com')
    @non_product_owner = User.new(email: 'non_product_owner@example.com')
    @dashboard = Dashboard.new(product_owner: @product_owner)
  end

  test 'access to dashboard is restricted to product owner' do
    assert @dashboard.display_visitor_counts
    refute @non_product_owner.display_visitor_counts
  end
end