require 'test_helper'

class SoftwareProductsControllerTest < ActionController::TestCase
  setup do
    @software_product = software_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:software_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create software_product" do
    assert_difference('SoftwareProduct.count') do
      post :create, software_product: { assets_category_id: @software_product.assets_category_id, description: @software_product.description, license: @software_product.license, license_no: @software_product.license_no, name: @software_product.name, version: @software_product.version }
    end

    assert_redirected_to software_product_path(assigns(:software_product))
  end

  test "should show software_product" do
    get :show, id: @software_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @software_product
    assert_response :success
  end

  test "should update software_product" do
    patch :update, id: @software_product, software_product: { assets_category_id: @software_product.assets_category_id, description: @software_product.description, license: @software_product.license, license_no: @software_product.license_no, name: @software_product.name, version: @software_product.version }
    assert_redirected_to software_product_path(assigns(:software_product))
  end

  test "should destroy software_product" do
    assert_difference('SoftwareProduct.count', -1) do
      delete :destroy, id: @software_product
    end

    assert_redirected_to software_products_path
  end
end
