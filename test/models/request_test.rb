require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  
  setup do
      @valid_data = {
        :title        => 'Test Title',
        :details      => 'Test Details',
        :requestor_id => users(:requestor_one).id
      }
  end
  
  test "should not save request without title" do
    @valid_data.delete(:title)
    request = Request.new(@valid_data)
    assert_not request.save, "Saved the request without a title"
  end
  
  test "should not save request without details" do
    @valid_data.delete(:details)
    request = Request.new(@valid_data)
    assert_not request.save, "Saved the request without details"
  end
  
  test "should not save request without requestor ID" do
    @valid_data.delete(:requestor_id)
    request = Request.new(@valid_data)
    assert_not request.save, "Saved the request without requestor ID"
  end
  
  test "should save with valid data" do
    request = Request.new(@valid_data)
    assert request.save, "Did not save the request with valid data"
  end
  
  test "should default complete to false" do
    request = Request.new(@valid_data)
    assert_not request.complete, "Requests should initialise not complete"
  end
end
