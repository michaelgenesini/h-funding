require 'test_helper'

class ScaffoldControllerTest < ActionController::TestCase
  test "should get Costs" do
    get :Costs
    assert_response :success
  end

end
