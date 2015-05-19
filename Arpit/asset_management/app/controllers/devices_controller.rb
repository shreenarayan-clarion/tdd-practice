class DevicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device, only: [:show, :edit, :update, :destroy, :destroy_assignment]
  before_action :device_categories, :employees, :branches, only: [:edit, :update, :new, :create]

  # GET /device
  # GET /device.json
  def index
    @devices = Device.send(params[:deleted] ? :inactive : :active)
  end

  # GET /device/1
  # GET /device/1.json
  def show
    @devices = @device.child_devices
  end

  # GET /device/new
  def new
    @device = Device.new
    @device.more_devices.build
  end

  # GET /device/1/edit
  def edit
    @parent_devices = (@device.branch.devices.where(parent_id: nil, status: ['assigned', 'instock']).active << @device.parent).compact.uniq
    redirect_to devices_path, alert: "You can't edit this device." if @device.deleted_at.present?
  end

  # POST /device
  # POST /device.json
  def create
    params[:device].merge!(params[:device][:more_devices_attributes].first[1])  if params[:device][:more_devices_attributes].first
    params[:device][:more_devices_attributes].except!(params[:device][:more_devices_attributes].keys.first) if params[:device][:more_devices_attributes].first   
    @device = Device.new(device_params)
    @device.status_date = Date.today
	  @device.status = @device.parent_id.present? ? @device.parent.status : 'instock'
    if Device.test_uniquness(params)
      respond_to do |format|
        if @device.save
          @device.add_more_devices(params[:device][:more_devices_attributes])
          format.html { redirect_to devices_url, notice: "Device(s) successfully created." }
          format.json { render :show, status: :created, location: @device }
        else
          format.html { render :new }
          format.json { render json: @device.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "Serial Numbers are alredy been taken"
      params[:device][:more_devices_attributes].values.each do |device|
        @device.more_devices.build(serial_number: device['serial_number'],model_number: device['model_number'])
      end if params[:device][:more_devices_attributes]
      @parent_devices = (@device.branch.devices.where(parent_id: nil, status: ['assigned', 'instock']).active << @device.parent).compact.uniq
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device/1
  # PATCH/PUT /device/1.json
  def update
    @device.status_date = Date.today
    respond_to do |format|
      @device.parent_id = device_params[:parent_id]
      device_attr = device_params
      device_attr[:status] = @device.parent.status if device_attr[:status].blank?
      device_attr[:branch_id] = @device.parent.branch_id if device_attr[:branch_id].blank?

      if @device.update(device_attr)
        if @device.status != 'assigned'
          @device.device_assignments.where(unassign_date: nil).update_all(unassign_date: DateTime.now)  
        end
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        @parent_devices = (@device.branch.devices.where(parent_id: nil, status: ['assigned', 'instock']).active << @device.parent).compact.uniq
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device/1
  # DELETE /device/1.json
  def destroy
    @device = Device.find(params[:id])
    if @device.device_category.deleted_at.present?
      message = {alert: 'This device can not be reverted. Device Category is not available'}
    else
      update_params = {status: 'instock', employee_id: nil, deleted_at: (params[:revert] ? nil : DateTime.now)}
      Device.child_devices(@device.id).update_all(update_params)
      @device.update(update_params)
      message = {notice: "Device was successfully #{params[:revert] ? 'reverted' : 'deleted'}."}
    end
    respond_to do |format|
      format.html { redirect_to devices_url, message  }
      format.json { head :no_content }
    end
  end

  def assignment
    if params[:device].present?
      @device = Device.new(branch_id: device_params[:branch_id], device_category_id: device_params[:device_category_id])
      @branch = @device.branch
      @devices = @branch.devices.where(status: 'instock', device_category_id: @device.device_category_id)
      @employees = @branch.employees
      @device_assignment = DeviceAssignment.new(device_params[:device_assignments])
    else
      @device = Device.new()
      @device.device_assignments.build
    end
    respond_to do |format|
      if params[:device].present? && device_params.key?(:device_assignments) && @device_assignment.valid?
        assignment = device_params[:device_assignments]
        DeviceAssignment.create_assignment(assignment[:device_id], assignment[:employee_id], assignment[:assign_date])
        Device.find(assignment[:device_id]).update(status: 'assigned', employee_id: assignment[:employee_id], assign_date: assignment[:assign_date])
        format.html { redirect_to(device_path(id: assignment[:device_id]), notice: 'Device Assignment was successfully created.')}
      else
        format.html { render :assignment }
      end
    end
  end

  def destroy_assignment
    DeviceAssignment.find(params[:device_assignment_id]).try(:destroy)
    @device.update(status: 'instock', employee_id: nil) if @device.device_assignments.where(unassign_date: nil).blank?
    redirect_to(device_path(id: params[:id]), notice: 'Device Assignment was successfully destroyed.')
  end

  def update_assignment
    respond_to do |format|
      @device_assignment = DeviceAssignment.find(params[:device_assignment_id])
      if @device_assignment.update(unassign_date: params[:unassign_date])
        @device_assignment.device.update(status: 'instock', employee_id: nil) if @device_assignment.unassign_date_was.present?
        message = {notice: 'Device Assignment was successfully updated.', unassign_date: @device_assignment.unassign_date.to_s, status: @device_assignment.device.to_status}
      else
        message = {errors: @device_assignment.errors.messages.values.join('</br>')||'Device Assignment cannot be update to this date'}
      end
      format.json { render :json => message }
    end
  end

  def check_serial_uniqueness
    if Device.test_uniquness(params)
      render :text => 0 and return false 
    else
      render :text => 1 and return false 
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:invoice_id, :vendor_id, :serial_number, :model_number, :ip_address, :status, :status_date, :branch_id, :warranty, :client_id, :device_category_id, :parent_id, :employee_id, :deleted_at, :device_identifier, :purchase_date, :lifetime_warranty, :warranry_year, :warranry_month, device_assignments: [:employee_id, :device_id, :assign_date] )
    end

    def device_categories
      @device_categories = DeviceCategory.active
    end

    def employees
      @employees = @device.present? ? @device.branch.employees : Employee.active
    end

    def branches
      @branches = Branch.active
    end
end
