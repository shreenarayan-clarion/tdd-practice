class PurchaseOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase_order, only: [:show, :edit, :update, :destroy]
  before_action :set_quotations, only: [:new,:create]
  before_action :check_permission, only: [:edit, :destroy, :update]

  # GET /purchase_orders
  # GET /purchase_orders.json
  def index
    @purchase_orders = PurchaseOrder.all
  end

  # GET /purchase_orders/1
  # GET /purchase_orders/1.json
  def show
  end

  # GET /purchase_orders/new
  def new
    if params[:quotation_id].present?
      @quotation = Quotation.find(params[:quotation_id])
      @device_transactions = @quotation.device_transactions
      @device_transactions.each do |po|
        po.purchase_title = po.quotation_title 
        po.purchase_quantity = po.quotation_quantity
        po.purchase_price = po.quotation_price
        po.purchase_description = po.quotation_description
      end
      #@purchase_order.set_purchase_order(@device_transactions)
    else
      @quotation = Quotation.new
    end
    @purchase_order = @quotation.build_purchase_order
    @uploads =   @purchase_order.uploads.build
    @purchase_order.on_date = @quotation.blank? ? '' : @quotation.on_date
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  # GET /purchase_orders/1/edit
  def edit
    @uploads = @purchase_order.uploads.blank? ? @purchase_order.uploads.build : @purchase_order.uploads  
  end

  # POST /purchase_orders
  # POST /purchase_orders.json
  def create
    # render text: params.inspect and return false
    @quotation = Quotation.find(params[:quotation_id])
    respond_to do |format|
      if @quotation.update(quotation_params)
        @quotation.device_transactions.update_all(purchase_order_id: @quotation.purchase_order.id)
        # @purchase_order.create_transactions(params[:purchase_order][:device_transactions_attributes])
        format.html { redirect_to @quotation.purchase_order, notice: 'Purchase order was successfully created.' }
        format.json { render :show, status: :created, location: @quotation.purchase_order }
      else
        @purchase_order = @quotation.purchase_order
        @device_transactions = @quotation.device_transactions
        @uploads = @purchase_order.uploads.build
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_orders/1
  # PATCH/PUT /purchase_orders/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        @quotation.device_transactions.update_all(purchase_order_id: @quotation.purchase_order.id)
        format.html { redirect_to @quotation.purchase_order, notice: 'Purchase order was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation.purchase_order }
      else
        @purchase_order = @quotation.purchase_order
        @device_transactions = @quotation.device_transactions
        @uploads = @purchase_order.uploads.blank? ? @purchase_order.uploads.build : @purchase_order.uploads  
        format.html { render :edit }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_orders/1
  # DELETE /purchase_orders/1.json
  def destroy
    @purchase_order.destroy
    respond_to do |format|
      format.html { redirect_to purchase_orders_url, notice: 'Purchase order was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_order
      @purchase_order = PurchaseOrder.includes(:device_transactions).find(params[:id])
      @device_transactions = @purchase_order.device_transactions
      @quotation = @purchase_order.quotation
    end

    def quotation_params
      params.require(:quotation).permit(:identifier, :quotation_id, :on_date,purchase_order_attributes: [:quotation_id, :on_date,:id,uploads_attributes: [:name,:attachment, :attachment_file_name, :attachment_content_type, :attachment_file_size]],device_transactions_attributes: [:purchase_title, :purchase_quantity, :purchase_price, :purchase_description,:id, :purchase_notes])
    end

    # To display quotations only whose purchase orders are not generated
    def set_quotations
      qid = PurchaseOrder.select(:quotation_id).map(&:quotation_id)
      @quotations = Quotation.where.not(id: qid)
    end

    def check_permission
      redirect_to purchase_orders_path, alert: "You can't edit this Purchase Order." unless @purchase_order.edit?
    end
end
