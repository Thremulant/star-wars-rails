require "test_helper"

class RacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get races_index_url
    assert_response :success
  end
end
