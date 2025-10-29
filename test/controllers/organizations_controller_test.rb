require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get switch" do
    get organizations_switch_url
    assert_response :success
  end
end
