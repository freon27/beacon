require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:requests)
  end
end
