class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]  
  before_action :set_purchase_orders, only: [:new,:create]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    if params[:purchase_order_id]
      @purchase_order = PurchaseOrder.find_by_id(params[:purchase_order_id])
      @device_transactions = @purchase_order.device_transactions
      @device_transactions.each do |po|
        po.invoice_title = po.purchase_title
        po.invoice_quantity = po.purchase_quantity
        po.invoice_price = po.purchase_price
        po.invoice_description = po.purchase_description
      end
    else
      @purchase_order = PurchaseOrder.new
    end
    @invoice = @purchase_order.build_invoice
    @uploads= @invoice.uploads.build
    @invoice.on_date = @purchase_order.blank? ? '' : @purchase_order.on_date
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /invoices/1/edit
  def edit
    @uploads= @invoice.uploads.blank? ?   @invoice.uploads.build : @invoice.uploads
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @purchase_order = PurchaseOrder.find(params[:purchase_order_id])
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        @purchase_order.device_transactions.update_all(invoice_id: @purchase_order.invoice.id)
        format.html { redirect_to @purchase_order.invoice, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :ok, location: @purchase_order.invoice }
      else
        @invoice = @purchase_order.invoice
        @device_transactions = @purchase_order.device_transactions
        @uploads= @invoice.uploads.build
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @purchase_order.update(purchase_order_params)
        @purchase_order.device_transactions.update_all(invoice_id: @purchase_order.invoice.id)
        format.html { redirect_to @purchase_order.invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase_order.invoice}
      else
        @invoice = @purchase_order.invoice
        @uploads= @invoice.uploads.blank? ?   @invoice.uploads.build : @invoice.uploads
        format.html { render :new }
        format.json { render json: @purchase_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_purchase_order
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_purchase_orders
      purchase_order_ids = Invoice.select(:purchase_order_id).map(&:purchase_order_id)
      @purchase_orders = PurchaseOrder.where.not(id: purchase_order_ids)
    end

    def set_invoice
      @invoice = Invoice.includes(:device_transactions).find(params[:id])
      @device_transactions = @invoice.device_transactions
      @purchase_order = @invoice.purchase_order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_order_params
      params.require(:purchase_order).permit(:identifier, :on_date, :purhcase_oder_id, device_transactions_attributes: [:invoice_price, :id, :invoice_notes], invoice_attributes: [:purchase_order_id, :on_date,:id, uploads_attributes: [:id,:name,:attachment, :attachment_file_name, :attachment_content_type, :attachment_file_size]])
    end
end
