require 'test_helper'

class TransfersControllerTest < ActionController::TestCase
  setup do
    @transfer = transfers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transfers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transfer" do
    assert_difference('Transfer.count') do
      post :create, transfer: { from_location: @transfer.from_location, to_location: @transfer.to_location, transfer_date: @transfer.transfer_date, transferable_id: @transfer.transferable_id, transferable_type: @transfer.transferable_type, transferee: @transfer.transferee }
    end

    assert_redirected_to transfer_path(assigns(:transfer))
  end

  test "should show transfer" do
    get :show, id: @transfer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transfer
    assert_response :success
  end

  test "should update transfer" do
    patch :update, id: @transfer, transfer: { from_location: @transfer.from_location, to_location: @transfer.to_location, transfer_date: @transfer.transfer_date, transferable_id: @transfer.transferable_id, transferable_type: @transfer.transferable_type, transferee: @transfer.transferee }
    assert_redirected_to transfer_path(assigns(:transfer))
  end

  test "should destroy transfer" do
    assert_difference('Transfer.count', -1) do
      delete :destroy, id: @transfer
    end

    assert_redirected_to transfers_path
  end
end
