class DeviceRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_device_request, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:edit, :destroy, :update]

  # GET /device_requests
  # GET /device_requests.json
  def index
    @device_requests = DeviceRequest.all
  end

  # GET /device_requests/1
  # GET /device_requests/1.json
  def show
  end

  # GET /device_requests/new
  def new
    @device_request = DeviceRequest.new
    @uploads = @device_request.uploads.build
    @device_request.requested_transactions.build
  end

  # GET /device_requests/1/edit
  def edit
    @requested_transactions = @device_request.requested_transactions
    @device_request.vendor_ids = @device_request.device_transactions.map(&:vendor_id).uniq.compact||[]
    @uploads = @device_request.uploads.blank? ? @device_request.uploads.build : @device_request.uploads  
  end

  # POST /device_requests
  # POST /device_requests.json
  def create
    # render text: params.inspect and return false
    @device_request = DeviceRequest.new(device_request_params)
    respond_to do |format|
      if @device_request.save
        format.html { redirect_to @device_request, notice: 'Device request was successfully created.' }
        format.json { render :show, status: :created, location: @device_request }
      else
        format.html { render :new }
        format.json { render json: @device_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_requests/1
  # PATCH/PUT /device_requests/1.json
  def update
    respond_to do |format|
      if @device_request.update(device_request_params)
        @device_request.update_relevant_records
        format.html { redirect_to @device_request, notice: 'Device request was successfully updated.' }
        format.json { render :show, status: :ok, location: @device_request }
      else
        @uploads = @device_request.uploads.blank? ? @device_request.uploads.build : @device_request.uploads  
        format.html { render :edit }
        format.json { render json: @device_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_requests/1
  # DELETE /device_requests/1.json
  def destroy
    @device_request.destroy
    respond_to do |format|
      format.html { redirect_to device_requests_url, notice: 'Device request was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_request
      @device_request = DeviceRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_request_params
      params.require(:device_request).permit(:on_date, vendor_ids: [],uploads_attributes: [:id,:name,:attachment, :attachment_file_name, :attachment_content_type, :attachment_file_size] , requested_transactions_attributes: [:id, :request_title, :device_category_id, :request_quantity, :request_description, :_destroy])
    end

    def check_permission
      redirect_to device_requests_path, alert: "You can't edit this Device Request." unless @device_request.edit?
    end
end
