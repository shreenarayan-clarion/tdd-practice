require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { department: @employee.department, designation: @employee.designation, email: @employee.email, employee_number: @employee.employee_number, first_name: @employee.first_name, helpdesk_id: @employee.helpdesk_id, join_date: @employee.join_date, last_name: @employee.last_name, location_id: @employee.location_id, pandian_id: @employee.pandian_id, pm_tool_id: @employee.pm_tool_id, resign_date: @employee.resign_date, sapience_id: @employee.sapience_id, skype_id: @employee.skype_id, technology: @employee.technology, wiki_id: @employee.wiki_id }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    patch :update, id: @employee, employee: { department: @employee.department, designation: @employee.designation, email: @employee.email, employee_number: @employee.employee_number, first_name: @employee.first_name, helpdesk_id: @employee.helpdesk_id, join_date: @employee.join_date, last_name: @employee.last_name, location_id: @employee.location_id, pandian_id: @employee.pandian_id, pm_tool_id: @employee.pm_tool_id, resign_date: @employee.resign_date, sapience_id: @employee.sapience_id, skype_id: @employee.skype_id, technology: @employee.technology, wiki_id: @employee.wiki_id }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
