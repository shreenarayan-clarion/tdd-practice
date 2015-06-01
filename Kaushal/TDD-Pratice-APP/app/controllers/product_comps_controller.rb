class ProductCompsController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_product
  before_action :set_product_comp, only: [:show, :edit, :update, :destroy]

  # GET /product_comps
  # GET /product_comps.json
  def index
    authorize Product
    @product_comps =  initialize_grid(@product.components, per_page: 10)
  end

  # GET /product_comps/1
  # GET /product_comps/1.json
  def show
    authorize @product_comp
  end

  # GET /product_comps/new
  def new
    authorize Product
    @product_comp = @product.components.new
  end

  # GET /product_comps/1/edit
  def edit
    authorize @product_comp
  end

  # POST /product_comps
  # POST /product_comps.json
  def create
    authorize Product
    @product_comp = @product.components.new(product_comp_params)

    respond_to do |format|
      if @product_comp.save
        format.html { redirect_to product_product_comps_url, notice: 'Product comp was successfully created.' }
        format.json { render :show, status: :created, location: @product_comp }
      else
        format.html { render :new }
        format.json { render json: @product_comp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_comps/1
  # PATCH/PUT /product_comps/1.json
  def update
    authorize @product_comp
    respond_to do |format|
      if @product_comp.update(product_comp_params)
        format.html { redirect_to product_product_comps_url, notice: 'Product comp was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_comp }
      else
        format.html { render :edit }
        format.json { render json: @product_comp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_comps/1
  # DELETE /product_comps/1.json
  def destroy
    authorize @product_comp
    @product_comp.destroy
    respond_to do |format|
      format.html { redirect_to product_product_comps_url, notice: 'Product comp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_product_comp
      @product_comp = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_comp_params
      params.require(:product).permit(:id, :name, :image, :description, :admin_id)
    end
end
