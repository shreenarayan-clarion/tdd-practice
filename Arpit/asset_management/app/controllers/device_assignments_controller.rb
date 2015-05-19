class DeviceAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device_assignment, only: [:show, :edit, :update, :destroy]
  

  # GET /device_assignments
  # GET /device_assignments.json
  def index
    @device_assignments = DeviceAssignment.all
  end

  # GET /device_assignments/1
  # GET /device_assignments/1.json
  def show
  end

  # GET /device_assignments/new
  def new
    @device_assignment = DeviceAssignment.new
  end

  # GET /device_assignments/1/edit
  def edit
    set_default_variables
    @device_assignment.branch_id = @device_assignment.branch.id
    @device_assignment.device_category_id = @device_assignment.device_category.id
  end

  # POST /device_assignments
  # POST /device_assignments.json
  def create
    @device_assignment = DeviceAssignment.new(device_assignment_params)

    respond_to do |format|
      if @device_assignment.save
        format.html { redirect_to @device_assignment.device, notice: 'Device assigned successfully.' }
        format.json { render :show, status: :created, location: @device_assignment }
      else
        set_default_variables
        format.html { render :new }
        format.json { render json: @device_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_assignments/1
  # PATCH/PUT /device_assignments/1.json
  def update
    respond_to do |format|
      if @device_assignment.update(device_assignment_params)
        format.html { redirect_to @device_assignment.device, notice: 'Device assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_assignment }
      else
        set_default_variables
        format.html { render :edit }
        format.json { render json: @device_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_assignments/1
  # DELETE /device_assignments/1.json
  def destroy
    @device_assignment.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: "Device assignment was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_assignment
      @device_assignment = DeviceAssignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_assignment_params
      params.require(:device_assignment).permit(:device_id, :employee_id, :assign_date, :unassign_date, :branch_id, :device_category_id)
    end

    def set_default_variables
      @devices = (Device.find_by_params({branch_id: @device_assignment.branch.try(:id), device_category_id: @device_assignment.device_category.try(:id)}, false).where(status: 'instock').active << @device_assignment.device).uniq.compact.uniq
      @employees = (Employee.find_by_params({branch_id: @device_assignment.branch.try(:id)}, false).active << @device_assignment.employee).uniq.compact.uniq
    end
end