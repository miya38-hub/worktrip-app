require "test_helper"

class Public::AnalyticsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_analytics_index_url
    assert_response :success
  end
end
