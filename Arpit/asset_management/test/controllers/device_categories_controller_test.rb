require 'test_helper'

class DeviceCategoriesControllerTest < ActionController::TestCase
  setup do
    @device_category = device_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:device_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create device_category" do
    assert_difference('DeviceCategory.count') do
      post :create, device_category: { name: @device_category.name }
    end

    assert_redirected_to device_category_path(assigns(:device_category))
  end

  test "should show device_category" do
    get :show, id: @device_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @device_category
    assert_response :success
  end

  test "should update device_category" do
    patch :update, id: @device_category, device_category: { name: @device_category.name }
    assert_redirected_to device_category_path(assigns(:device_category))
  end

  test "should destroy device_category" do
    assert_difference('DeviceCategory.count', -1) do
      delete :destroy, id: @device_category
    end

    assert_redirected_to device_categories_path
  end
end
