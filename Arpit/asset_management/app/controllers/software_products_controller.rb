class SoftwareProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_software_product, only: [:show, :edit, :update, :destroy]

  # GET /software_products
  # GET /software_products.json
  def index
    @software_products = SoftwareProduct.send(params[:deleted] ? :inactive : :active)
  end

  # GET /software_products/1
  # GET /software_products/1.json
  def show
  end

  # GET /software_products/new
  def new
    @software_product = SoftwareProduct.new
  end

  # GET /software_products/1/edit
  def edit
    redirect_to software_products_path, alert: "You can't edit this software." if @software_product.deleted_at.present?
  end

  # POST /software_products
  # POST /software_products.json
  def create
    @software_product = SoftwareProduct.new(software_product_params)

    respond_to do |format|
      if @software_product.save
        format.html { redirect_to @software_product, notice: 'Software product was successfully created.' }
        format.json { render :show, status: :created, location: @software_product }
      else
        format.html { render :new }
        format.json { render json: @software_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /software_products/1
  # PATCH/PUT /software_products/1.json
  def update
    respond_to do |format|
      if @software_product.update(software_product_params)
        format.html { redirect_to @software_product, notice: 'Software product was successfully updated.' }
        format.json { render :show, status: :ok, location: @software_product }
      else
        format.html { render :edit }
        format.json { render json: @software_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /software_products/1
  # DELETE /software_products/1.json
  def destroy
    if @software_product.device_category.deleted_at.present?
      message = {alert: 'This device can not be reverted. Device Category is not available'}
    else
      @software_product.update_attribute(:deleted_at, params[:revert] ? nil : DateTime.now)
      message = { notice: "Software product was successfully #{params[:revert] ? 'reverted' : 'deleted'}."}
    end
    respond_to do |format|
      format.html { redirect_to software_products_url, message}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_product
      @software_product = SoftwareProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def software_product_params
      params.require(:software_product).permit(:name, :description, :device_category_id, :version, :license, :license_no, :purchase_date)
    end
end
