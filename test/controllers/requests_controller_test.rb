require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  
  test "should get index" do
      sign_in users(:requestor_one)
      get :index, {'show_complete' => true}
      assert_response :success, "Response success"
      assert_not_nil assigns(:requests), "Assigns @requests"
      assert_equal 3, assigns(:requests).size, "Only assigns open requests by default"
  end
  
  
  test "should get index with show all" do
      sign_in users(:requestor_one)
      get :index
      assert_response :success, "Response success"
      assert_not_nil assigns(:requests), "Assigns @requests"
      assert_equal 2, assigns(:requests).size, "Only assigns open requests by default"
  end
  
  
  test "should get show" do
      sign_in users(:requestor_one)
      get :show, {'id' => Request.first}
      assert_response :success, "Response success"
      assert_not_nil assigns(:request), "Assigns @request"
      #assert_not_nil assigns(:requestor), "Assigns @requestor"
      
  end
  
  
  test "should get new" do
      sign_in users(:requestor_one)
      get :new
      assert_response :success, "Response success"
  end
  
  test "should create request" do
      sign_in users(:requestor_one)
      assert_difference('Request.count') do
        post :create, request: {
          :title            => 'test',
          :details          => 'test',
          :urgency          => 1,
          :relevance_period => 1
        }
      end
  
      #assert_redirected_to post_path(assigns(:post))
  end
  
  test "should broadcast email when item created" do 
      sign_in users(:requestor_one)
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do 
        post :create, request: {
          :title            => 'test title',
          :details          => 'details of the test',
          :urgency          => 1,
          :relevance_period => 1
        }
      end
      bc_email = ActionMailer::Base.deliveries.last
      assert_equal "BEACON: nick@fake.com has created request 'test title'", bc_email.subject
      assert_equal User.all.size, bc_email.to.size
      assert_match(/details of the test/, bc_email.body.to_s)
  end
  
  test "should send email to requestor when item completed" do 
      sign_in users(:requestor_one)
      @request.env['HTTP_REFERER'] = 'dummy_url'
      assert_difference 'ActionMailer::Base.deliveries.size', +1 do 
        put :update, id: requests(:one).id, request: {
          :complete => true
        }
      end
      bc_email = ActionMailer::Base.deliveries.last
      assert_equal "BEACON: nick@fake.com has set request 'Request for something' to complete", bc_email.subject
      assert_equal requests(:one).requestor.email, bc_email.to[0], "Should email the requestor"
      assert_match(/#{requests(:one).details}/, bc_email.body.to_s)
  end
end
