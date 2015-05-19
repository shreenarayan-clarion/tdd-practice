require 'test_helper'

class DeviceRequestsControllerTest < ActionController::TestCase
  setup do
    @device_request = device_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_request" do
    assert_difference('DeviceRequest.count') do
      post :create, device_request: { description: @device_request.description, device_category_id: @device_request.device_category_id, on_date: @device_request.on_date, title: @device_request.title, vendor_id: @device_request.vendor_id }
    end

    assert_redirected_to device_request_path(assigns(:device_request))
  end

  test "should show device_request" do
    get :show, id: @device_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_request
    assert_response :success
  end

  test "should update device_request" do
    patch :update, id: @device_request, device_request: { description: @device_request.description, device_category_id: @device_request.device_category_id, on_date: @device_request.on_date, title: @device_request.title, vendor_id: @device_request.vendor_id }
    assert_redirected_to device_request_path(assigns(:device_request))
  end

  test "should destroy device_request" do
    assert_difference('DeviceRequest.count', -1) do
      delete :destroy, id: @device_request
    end

    assert_redirected_to device_requests_path
  end
end
