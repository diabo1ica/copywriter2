require "test_helper"

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get invalid_token" do
    get errors_invalid_token_url
    assert_response :success
  end
end
