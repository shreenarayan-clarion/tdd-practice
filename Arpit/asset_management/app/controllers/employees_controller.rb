class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET /employees
  # GET /employees.json
  # This method will give  active and delted  records of the employees as per the params
  def index
      @employees = Employee.send(params[:deleted] ? :inactive : :active)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  
  def edit
    # This method will restrct the deleted employee to be edited
    redirect_to employees_path, alert: "You can't edit this device employee." if @employee.deleted_at.present?
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    # This method will update employee from active to delete status and will not be used any more as active 
    @employee.update_attributes(deleted_at: params[:revert] ? nil : DateTime.now)
    respond_to do |format|
      format.html { redirect_to employees_url(), notice: "Employee was successfully #{params[:revert] ? 'reverted' : 'deleted'}." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :employee_number, :designation, :technology, :department, :branch_id, :join_date, :resign_date, :skype_id, :pm_tool_id, :pandian_id, :wiki_id, :sapience_id, :helpdesk_id)
    end
end
