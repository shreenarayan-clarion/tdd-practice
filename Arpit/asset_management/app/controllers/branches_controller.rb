class BranchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_branch, only: [:show, :edit, :update, :destroy, :associate_data]

  # GET /branches
  # GET /branches.json
  def index
    # active will fetch all the records which has nil value for deleted_at
    @branches = Branch.send(params[:deleted] ? :inactive : :active)
  end

  # GET /branches/1
  # GET /branches/1.json
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
    redirect_to branches_path, alert: "You can't edit this branch." if @branch.deleted_at.present?
  end

  # POST /branches
  # POST /branches.json
  def create
    @branch = Branch.new(branch_params)

    respond_to do |format|
      if @branch.save
        format.html { redirect_to @branch, notice: 'Branch was successfully created.' }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1
  # PATCH/PUT /branches/1.json
  def update
    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @branch, notice: 'Branch was successfully updated.' }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1
  # DELETE /branches/1.json
  def destroy
    if @branch.update_attributes( deleted_at: params[:revert] ? nil : DateTime.now)
      message = {notice: "Branch was successfully #{params[:revert] ? 'reverted' : 'deleted'}."  }
    else
      message = {alert: @branch.errors.first[1]}
    end
    respond_to do |format|
      format.html { redirect_to branches_url, message}
      format.json { head :no_content }
    end
  end

  def associate_data
    devices_condition = {}
    devices_condition[:device_category_id] = params[:device_category_id] if params[:device_category_id].present?
    respond_to do |format|
      format.json { render :json => {employees: @branch.employees.active, devices: @branch.devices.where(status: ['assigned', 'instock'], parent_id: nil).where(devices_condition).active} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def branch_params
      params.require(:branch).permit(:name, :parent_id, :deleted_at)
    end
end
