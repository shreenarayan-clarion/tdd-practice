class QuotationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quotation, only: [:show, :edit, :update, :destroy]
  before_action :device_request_list , only: [:new, :create]
  before_action :check_permission, only: [:edit, :destroy, :update]

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = Quotation.all
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
  end

  # GET /quotations/new
  def new
    if params[:device_request_id]
      @device_request = DeviceRequest.find(params[:device_request_id])
      if @device_request
        vendor_ids = DeviceTransaction.where(device_request_id: params[:device_request_id], quotation_id: nil).map(&:vendor_id).uniq
        @vendors = Vendor.where(:id => vendor_ids)
        @device_transactions = @device_request.device_transactions.where(vendor_id: params[:vendor_id])
        @device_transactions.each do |po|
          po.quotation_title = po.request_title
          po.quotation_quantity = po.request_quantity
          po.quotation_description = po.request_description
        end
        @quotation = @device_request.quotations.build
        @quotation.device_request_id = params[:device_request_id]
        @quotation.vendor_id = params[:vendor_id]
      end
    else
      @device_request = DeviceRequest.new
      @quotation = @device_request.quotations.build
    end
    @uploads = @quotation.uploads.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /quotations/1/edit
  def edit
    @device_request = Quotation.find(params[:id]).device_request
    @uploads = @quotation.uploads.blank? ? @quotation.uploads.build : @quotation.uploads
  end

  # POST /quotations
  # POST /quotations.json
  def create
    @device_request = DeviceRequest.find(params[:device_request_id])
    respond_to do |format|
      if @device_request.update(device_request_params)
        transactions = @device_request.device_transactions.where(vendor_id:  params[:vendor_id])
        transactions.update_all(quotation_id: @device_request.quotations.last.id)
        format.html { redirect_to @device_request.quotations.last, notice: 'Quotation was successfully created.' }
        format.json { render :show, status: :created, location: @device_request.quotations.last }
      else
        @quotation = @device_request.quotations.last
        vendor_ids = DeviceTransaction.where(device_request_id: params[:device_request_id], quotation_id: nil).map(&:vendor_id).uniq
        @vendors = Vendor.where(:id => vendor_ids)
        @quotation.vendor_id = params[:vendor_id]
        @device_transactions = @device_request.device_transactions.select{|transaction| transaction.vendor_id.to_s ==  params[:vendor_id]}
        @uploads = @quotation.uploads.build
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @device_request.update(device_request_params)
        format.html { redirect_to @quotation, notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation}
      else
        @device_transactions = @device_request.device_transactions.select {|transaction| transaction[:quotation_id] == @quotation.id }
        @uploads = @quotation.uploads.blank? ? @quotation.uploads.build : @quotation.uploads
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url, notice: 'Quotation was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def request_vendors
    vendor_ids = DeviceTransaction.where(:device_request_id => params[:id], quotation_id: nil).map(&:vendor_id).uniq
    @vendors = Vendor.where(:id => vendor_ids)
    respond_to do |format|
      format.json { render :json => { :vendors => @vendors } }
    end
  end

  def get_requests
	@device_request = DeviceRequest.find(params[:device_request_id])
    @transactions = DeviceTransaction.where(vendor_id: params[:vendor_id], device_request_id: params[:device_request_id])
    @transactions.each do |transaction|
      transaction.quotation_title = transaction.request_title
      transaction.quotation_quantity = transaction.request_quantity
      transaction.quotation_description = transaction.request_description
    end
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.includes(:device_transactions, :device_request).find(params[:id])
      @device_transactions = @quotation.device_transactions
      @device_request = @quotation.device_request
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_request_params
      params.require(:device_request).permit(:identifier, :device_request_id, :on_date,quotations_attributes:[:device_request_id,:on_date,:id,uploads_attributes: [:id,:name,:attachment, :attachment_file_name, :attachment_content_type, :attachment_file_size]],device_transactions_attributes:[:quotation_title,:quotation_quantity,:quotation_price,:quotation_description,:id, :quotation_notes])
    end

    def device_request_list
      device_request_ids = DeviceTransaction.where(quotation_id: nil).map(&:device_request_id).uniq
      @device_requests = DeviceRequest.where(id: device_request_ids)
    end

    def check_permission
      redirect_to quotations_path, alert: "You can't edit this Quotation." unless @quotation.edit?
    end
end
