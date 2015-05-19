class TransfersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]
  before_action :redirect_page, only: [:index, :new]
  before_action :set_resources, only: [:edit]

  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = Transfer.resources(params[:resource].capitalize)
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = params[:resource].capitalize.constantize.new.transfers.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    respond_to do |format|
      if @transfer.save
        @transfer.transferable.update( branch_id: transfer_params[:to_location_id] )
        if @transfer.transferable_type == "Employee"
          @transfer.transferable.devices.update_all( status: "instock", status_date: Date.today )
          @transfer.transferable.device_assignments.update_all(unassign_date: @transfer.transfer_date)
        end 
        format.html { redirect_to @transfer, notice: 'Transfer was successfully created.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        set_resources
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transfers/1
  # PATCH/PUT /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        latest_transfer = Transfer.latest_transfer(@transfer.transferable_id, @transfer.transferable_type)
        if @transfer.transferable_type == "Employee" && @transfer.from_location != @transfer.transferable.branch
          @transfer.transferable.devices.update_all( status: "instock", status_date: Date.today )
          @transfer.transferable.device_assignments.where.not(unassign_date: nil).update_all(unassign_date: @transfer.transfer_date)
        end 
        @transfer.transferable.update(branch_id: @transfer.to_location_id) if latest_transfer == @transfer
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer }
      else
        set_resources
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    latest_transfer = Transfer.latest_transfer(@transfer.transferable_id, @transfer.transferable_type)
    @transfer.destroy
    @transfer.transferable.update(branch_id: @transfer.from_location_id) if latest_transfer == @transfer
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def resources
    set_resources
    respond_to do |format|
      format.json { render :json => {:resource => @resource, :resource_name => @transferable_type }}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:transferable_id, :transferable_type, :from_location_id, :to_location_id, :transfer_date, :transferee_id)
    end

    def redirect_page
      redirect_to root_path if !params[:resource].present? || !['employee', 'Employee','device', 'Device'].include?(params[:resource])
    end

    def set_resources
      @transferable_type, @branch_id, @transferable = @transfer.present? ? [@transfer.transferable_type, @transfer.from_location, @transfer.transferable] : [params[:resource], params[:id]]
      @resource = @transferable_type == "Employee" ? Employee.branch_employees(@branch_id, current_user.employee_id) : Device.unassigned.where(branch_id: @branch_id)
      @resource << @transferable if @transferable.present?
    end
end
